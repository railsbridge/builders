require 'test_helper'
 
class ProjectTest < ActiveSupport::TestCase
  
  should_have_db_column :org_name, :type => "string"    
  should_have_db_column :org_details, :type => "text"    
  should_have_db_column :contact_name, :type => "string"    
  should_have_db_column :contact_phone, :type => "string"    
  should_have_db_column :contact_email, :type => "string"    
  should_have_db_column :website, :type => "string"    
  should_have_db_column :description, :type => "text"    
  should_have_db_column :approved, :type => "boolean"
  
  should_validate_presence_of :org_name, :contact_name, :contact_email   
end