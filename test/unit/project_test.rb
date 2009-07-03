require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class ProjectTest < ActiveSupport::TestCase
  
  should_have_db_column :org_name,      :type => "string"    
  should_have_db_column :org_details,   :type => "text"    
  should_have_db_column :contact_name,  :type => "string"    
  should_have_db_column :contact_phone, :type => "string"    
  should_have_db_column :contact_email, :type => "string"    
  should_have_db_column :website,       :type => "string"    
  should_have_db_column :description,   :type => "text"    
  should_have_db_column :approved,      :type => "boolean"
  should_have_db_column :access_key,    :type => "string"
  should_have_db_column :notes,         :type => "text"
  should_have_db_column :status,        :type => "string"

  should_validate_presence_of :org_name, :contact_name, :contact_email

  should_not_allow_mass_assignment_of :access_key
  
  should_have_many :project_volunteers
  should_have_many :volunteers, :through => :project_volunteers

  should 'generate access key on create' do
    project = Factory.build(:project)
    assert_nil project.access_key

    project.save!
    project.reload
    assert_not_nil project.access_key
  end

  context '#authorized?' do
    setup { @project = Factory(:project, :approved => true) }
    
    should 'grant access with correct access_key' do
      access_key = @project.access_key

      assert @project.authorized?(access_key)
    end

    should 'not grant access with bad access_key' do
      assert ! @project.authorized?('bad-key')
    end
    
    should 'grant access to an admin' do
      user = Factory(:user, :admin => true)
      assert @project.authorized?(user)
    end

    should 'grant access to a team member' do
      user = Factory(:user)
      pv = @project.project_volunteers.build(:user => user)
      pv.role = 'volunteer'
      @project.save!

      assert @project.authorized?(user)
    end

    should 'not grant access to a non-admin, non-team member' do
      user = Factory(:user)
      assert ! @project.authorized?(user)
    end
  end

  context '#team_member?' do
    setup do
      @project = Factory(:project)
      @user = Factory(:user)
    end

    should 'be true if the user has volunteered for the project' do
      pv = @project.project_volunteers.build(:user => @user)
      pv.role = 'volunteer'
      @project.save!
      
      assert @project.team_member?(@user)
    end
    
    should 'be false if the user has not volunteered for the project' do
      assert ! @project.team_member?(@user)
    end
  end

  context "when a project is approved" do
    setup do
      @project = Factory(:project)
    end

    should "mark the project as approved" do
      @project.approve
      assert @project.approved
    end
  end
end
