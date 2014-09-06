class AddReferencesToProjects < ActiveRecord::Migration
  def change
    add_reference :projects, :schedules, index: true
  end
end
