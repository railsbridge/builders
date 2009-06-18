require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class ProjectVolunteerTest < ActiveSupport::TestCase
  
  should_belong_to  :user
  should_have_index :user_id
    
  should_belong_to  :project
  should_have_index :project_id

  should_have_enum_field :role, 'volunteer', 'tech_lead'

  should_not_allow_mass_assignment_of :role

  should_validate_presence_of :role
end
