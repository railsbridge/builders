require File.join(File.dirname(__FILE__), '..', 'test_helper')

class VolunteerForProjectTest < ActionController::IntegrationTest
  context 'a Volunteer visiting a Project page' do
    setup do 
      @user = Factory(:user)
      @project = Factory(:project)
    end
    
    context 'already working on this project' do
      setup do
        Factory(:project_volunteer, :user => @user, 
                                    :project => @project, 
                                    :role => 'volunteer')
      end
      
      should 'not display the Volunteer! button' do
        visit login_path
        fill_in 'Email', :with => @user.email
        fill_in 'Password', :with => 'secret'
        click_button 'LOGIN'

        visit project_path(@project)
        
        assert_contain @user.name
        assert_have_no_selector('input', :type => 'button', :value => 'Volunteer!')
      end
    end

    context 'not yet assigned to the project' do

      should 'be allowed to volunteer for a project' do
        visit login_path
        fill_in 'Email', :with => @user.email
        fill_in 'Password', :with => 'secret'
        click_button 'LOGIN'

        visit project_path(@project)
      
        click_button 'Volunteer!'
      
        assert_equal user_path(@user), path
        assert_contain 'Thanks for volunteering.'
        assert_contain @project.org_name
      end
    end
  end
end
