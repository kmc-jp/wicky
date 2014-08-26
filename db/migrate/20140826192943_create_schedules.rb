class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |table|
      table.string :name
      table.datetime :start
      table.datetime :end
      table.string :place
      table.belongs_to :project
      table.timestamps
    end
  end
end
