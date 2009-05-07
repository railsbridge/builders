class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email,               :null => false
      t.string :crypted_password,    :null => false
      t.string :password_salt,       :null => false
      t.string :persistence_token,   :null => false
      t.string :single_access_token, :null => false
      t.string :perishable_token,    :null => false
      
      t.string :name
      t.date :availability_starts
      t.date :availability_ends
      t.integer :hours_per_week
      t.text :notes

      t.timestamps
    end
    
  
  end

  def self.down

    drop_table :users
  end
end