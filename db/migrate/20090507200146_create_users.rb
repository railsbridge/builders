class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :email
      t.string :crypted_password
      t.string :password_salt
      t.string :persistance_token
      t.string :first_name
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