class AddDescriptionToSchedules < ActiveRecord::Migration
  def change
    add_column :schedules, :description, :text 
  end
end
