#!/usr/bin/ruby
# coding: utf-8

require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'tilt/haml'

set :views, "#{File.dirname(__FILE__)}/../views"

get '/' do
  haml :index
end

