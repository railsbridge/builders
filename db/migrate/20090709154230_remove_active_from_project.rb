class RemoveActiveFromProject < ActiveRecord::Migration
  def self.up
    remove_column :projects, :approved
  end

  def self.down
    add_column :projects, :approved, :boolean
  end
end
