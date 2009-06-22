class AddReceiveNotificationsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :receive_notifications, :boolean, :default => false
  end

  def self.down
    remove_column :users, :receive_notifications
  end
end
