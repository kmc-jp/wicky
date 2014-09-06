class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |table|
      table.string :name
      table.timestamps
    end
  end
end
