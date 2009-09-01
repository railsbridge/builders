require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TeamMemberFieldsForProjectTest < ActionController::IntegrationTest
  setup :featured

  context 'a site visitor' do
    setup do
      @project = Factory(:project)
      visit project_path(@project)
    end

    should 'not see the Project\'s Notes' do
      assert_not_contain('Notes')
      assert_not_contain("please help the")
    end
  end

  context 'a registered volunteer' do
    setup do
      login
      @project = Factory(:project)
    end

    context 'who has volunteered for project' do
      setup do
        Factory(:project_volunteer, :project => @project,
                                    :user => @user,
                                    :role => 'volunteer')

        visit project_path(@project)
      end

      should 'see the Project\'s Notes' do
        assert_contain('Notes')
        assert_contain("please help the")
      end

      should 'display the notes in Textile' do
        assert_have_selector('a', :href => 'http://sallystruthers.com')
      end

      should 'have the Edit link' do
        assert_have_selector('a', :href => edit_project_path(@project))
      end
    end

    context 'who has not volunteered' do
      setup { visit project_path(@project) }

      should 'not see the Project\'s Notes' do
        assert_not_contain('Notes')
        assert_not_contain("please help the")
      end
    end
  end
end
