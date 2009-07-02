class AddNotesToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :notes, :text
  end

  def self.down
    remove_column :projects, :notes
  end
end
