require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ProjectVolunteersControllerTest < ActionController::TestCase
  context 'on POST to create' do
    setup { @project = Factory(:project) }
    
    authenticated_user do
      setup { post :create, :project_volunteer => { :project_id => @project.id } }

      should_redirect_to("users's home page") { user_path(@user) }
      should_set_the_flash_to /thanks for volunteering/i
      should_change 'ProjectVolunteer.count', :by => 1
    end
    
  end
end
