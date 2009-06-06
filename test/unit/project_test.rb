require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class ProjectTest < ActiveSupport::TestCase
  
  should_have_db_column :org_name, :type => "string"    
  should_have_db_column :org_details, :type => "text"    
  should_have_db_column :contact_name, :type => "string"    
  should_have_db_column :contact_phone, :type => "string"    
  should_have_db_column :contact_email, :type => "string"    
  should_have_db_column :website, :type => "string"    
  should_have_db_column :description, :type => "text"    
  should_have_db_column :approved, :type => "boolean"
  should_have_db_column :access_key, :type => "string"

  should_validate_presence_of :org_name, :contact_name, :contact_email

  should_not_allow_mass_assignment_of :access_key

  should 'generate access key on create' do
    project = Factory.build(:project)
    assert_nil project.access_key

    project.save!
    project.reload
    assert_not_nil project.access_key
  end
end
