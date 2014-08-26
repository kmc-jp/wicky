
require 'sinatra/activerecord'

class Schedule < ActiveRecord::Base
  belongs_to :project
end

