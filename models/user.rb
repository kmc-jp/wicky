
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  has_many :participations
  has_many :projects, through: :participations
end

