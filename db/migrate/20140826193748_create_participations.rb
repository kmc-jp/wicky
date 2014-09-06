class CreateParticipations < ActiveRecord::Migration
  def change
    create_join_table :users, :projects, table_name: :participations do |table|
      table.index :user_id
      table.index :project_id
      table.boolean :is_leader
    end
  end
end
