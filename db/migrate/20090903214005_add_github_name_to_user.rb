class AddGithubNameToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :github_name, :string
  end

  def self.down
    remove_column :users, :github_name
  end
end
