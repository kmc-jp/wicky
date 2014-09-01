#!/usr/bin/ruby
# coding: utf-8

require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'sinatra/reloader'
require 'sinatra/assetpack'
require 'haml'
require 'tilt/haml'
require_relative '../models/user'
require_relative '../models/project'
require_relative '../models/participation'
require_relative '../models/schedule'
require_relative './haml/filters/kramdown'

module Wicky
  class App < Sinatra::Base

    register Sinatra::AssetPack

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      enable :method_override
      set :haml, :escape_html => true
      set :root, "#{File.dirname(__FILE__)}/../"
    end

    assets do
      serve '/js', from: 'assets/scripts'
      serve '/css', from: 'assets/stylesheets'

      js :main, '/js/main.js', [
        '/js/lib/jquery-2.1.1.js',
        '/js/wicky.js',
        '/js/wicky/ui.js',
        '/js/wicky/projects.js'
      ]
      css :main, '/css/main.css', [
        '/css/html5-doctor-reset-stylesheet.css'
      ]
      js_compression :closure
      css_compression :sass
    end

    helpers do
      def bind(id, api, &block)
        capture_haml do
          haml_tag 'div.ui-bind', { 'data-bind-id' => id, 'data-bind-update-api' => api }, &block
        end
      end
    end

    get '/' do
      haml :index, locals: {
        projects: Project.all,
        schedules: Schedule.all
      }
    end

    post '/projects/!add' do
      project_data = {
        name: params[:name]
      }
      project = Project.create(project_data)
      redirect "/projects/#{project.id}"
    end

    get '/projects/:id/' do |id|
      halt 404 unless Project.exists?(id)
      haml :projects, locals: {
        project: Project.find(id)
      }
    end

    get '/projects/:id/schedules/!list' do |id|
      halt 404 unless Project.exists?(id)
      haml :schedules, { layout: false }, { schedules: Project.find(id).schedules }
    end

    get '/projects/:id/users/!list' do |id|
      halt 404 unless Project.exists?(id)
      haml :users, { layout: false }, { users: Project.find(id).users }
    end

    get '/projects/:id/!show' do |id|
      halt 404 unless Project.exists?(id)
      haml :projects, { layout: false }, { project: Project.find(id) }
    end

    get '/schedules/:id/!show' do |id|
      halt 404 unless Schedule.exists?(id)
      haml :a_schedule, { layout: false }, { schedule: Schedule.find(id) }
    end

    get '/api/projects/:id.json' do |id|
      halt 404 unless Project.exists?(id)
      json Project.find(id).to_json
    end

    post '/api/projects' do
      project_data = {
        name: params[:name],
        summary: params[:summary]
      }
      json Project.create(project_data).to_json
    end

    put '/api/projects/:id' do |id|
      halt 404 unless Project.exists?(id)
      project_data = {
        name: params[:name],
        summary: params[:summary]
      }
      json Project.update(id, project_data).to_json
    end

    get '/api/users.json' do
      json User.all
    end

    get '/api/users/:id.json' do |id|
      halt 404 unless User.exists?(id)
      json User.find(id).to_json
    end

    post '/api/users' do
      user_data = {
        name: params[:name],
        email: params[:email]
      }
      halt 409 if User.exists?(user_data)
      json User.create(user_data).to_json
    end

    put '/api/users/:id' do |id|
      halt 404 unless User.exists?(id)
      user_data = {
        name: params[:name],
        email: params[:email]
      }
      json User.update(id, user_data).to_json
    end

    post '/api/participations' do
      user_data = {
        name: params[:name],
        email: params[:email]
      }
      user = User.find_or_create_by(user_data)
      user_id = user.id
      project_id = params[:project_id]
      halt 404 unless Project.exists?(project_id)
      project = Project.find(project_id)
      halt 409 if Participation.exists?(user_id: user_id, project_id: project_id)
      project.users.push user
      project.save
      json({
        project_id: project_id,
        user_id: user_id,
      })
    end

    post '/api/schedules' do
      project_id = params[:project_id]
      halt 404 unless Project.exists?(project_id)
      schedule_data = {
        name: params[:name],
        place: params[:place],
        start: time_for(params[:start]),
        end: time_for(params[:end]),
        project_id: project_id
      }
      json Schedule.create(schedule_data).to_json
    end

    put '/api/schedules/:id' do |id|
      project_id = params[:project_id]
      halt 404 unless Project.exists?(project_id)
      halt 404 unless Schedule.exists?(id)
      schedule_data = {
        name: params[:name],
        place: params[:place],
        start: time_for(params[:start]),
        end: time_for(params[:end]),
        description: params[:description],
        project_id: project_id
      }
      json Schedule.update(id, schedule_data).to_json
    end

    get '/api/kramdown' do
      text = params[:md]
      Kramdown::Document.new(text, {}).to_html
    end

    run! if app_file == $0

  end # class App
end # module Wicky

