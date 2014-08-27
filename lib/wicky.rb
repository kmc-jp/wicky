#!/usr/bin/ruby
# coding: utf-8

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/json'
require 'haml'
require 'tilt/haml'
require_relative '../models/user'
require_relative '../models/project'
require_relative '../models/participation'
require_relative '../models/schedule'
require_relative './haml/filters/kramdown'

set :method_override, true
set :haml, :escape_html => true
set :views, "#{File.dirname(__FILE__)}/../views"

get '/' do
  redirect '/projects'
end

get '/projects' do
  haml :index, locals: {
    projects: Project.all
  }
end

get '/projects/:id' do |id|
  halt 404 unless Project.exists?(id)
  haml :project, locals: {
    project: Project.find(id)
  }
end

get '/api/projects/:id.json' do |id|
  halt 404 unless Project.exists?(id)
  json Project.find(id).to_json
end

put '/api/projects/:id' do |id|
  project_data = {
    name: params[:name],
    summary: params[:summary]
  }
  if (Project.exists?(id)) then
    json Project.update(id, project_data).to_json
  else
    json Project.create(project_data).to_json
  end
end

