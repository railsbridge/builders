require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class ProjectsHelperTest < ActionView::TestCase

  context '#eligible_to_volunteer?' do
    setup do
      @project = Factory(:project)
      @user = Factory(:user)
    end
    
    context 'with a logged in volunteer' do
      setup do
        stub(self).logged_in? { true }
        stub(self).current_user { @user }
      end

      context 'not yet working on the project' do
        should 'be eligable to volunteer for project' do
          assert eligible_to_volunteer?
        end
      end
      
      context 'already working on the project' do
        setup { Factory(:project_volunteer, :user => @user, :project => @project) }
        
        should 'not be eligible to work for the project' do
          assert ! eligible_to_volunteer?
        end
      end
    end

    context 'without a logged in user' do
      setup { stub(self).logged_in? { false } }
      
      should 'not be eligible to volunteer for project' do
        assert ! eligible_to_volunteer?
      end
    end
  end
end
