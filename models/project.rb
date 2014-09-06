
require 'sinatra/activerecord'

class Project < ActiveRecord::Base
  has_many :participations
  has_many :users, through: :participations
  has_many :schedules
end

