
require 'sinatra/activerecord'

class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
end

