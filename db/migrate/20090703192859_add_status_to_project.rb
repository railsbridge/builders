class AddStatusToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :status, :string
    add_index :projects, :status
  end

  def self.down
    remove_index :projects, :column => :status
    remove_column :projects, :status
  end
end
