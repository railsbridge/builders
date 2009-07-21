class AddAliasesToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :aliases, :string
  end

  def self.down
    remove_column :users, :aliases
  end
end
