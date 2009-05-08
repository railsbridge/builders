require 'test_helper'
 
class UserTest < ActiveSupport::TestCase
  
  should_have_db_column :email, :type => "string"    
  should_have_db_column :crypted_password, :type => "string"    
  should_have_db_column :password_salt, :type => "string"    
  should_have_db_column :persistence_token, :type => "string"
  should_have_db_column :name, :type => "string"    
  should_have_db_column :availability_starts, :type => "date"    
  should_have_db_column :availability_ends, :type => "date"    
  should_have_db_column :hours_per_week, :type => "integer"    
  should_have_db_column :notes, :type => "text"
  should_have_db_column :single_access_token, :type => "string"
  should_have_db_column :perishable_token, :type => "string"
    
  should_be_authentic
  
  should_validate_presence_of :name
end