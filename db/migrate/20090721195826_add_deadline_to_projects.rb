class AddDeadlineToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :deadline, :date
  end

  def self.down
    remove_column :projects, :deadline
  end
end
