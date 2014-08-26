#!/usr/bin/ruby
# coding: utf-8

require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'tilt/haml'
require_relative '../models/user'
require_relative '../models/project'
require_relative '../models/participation'
require_relative '../models/schedule'

set :views, "#{File.dirname(__FILE__)}/../views"

get '/' do
  haml :index, locals: { projects: Project.all }
end

