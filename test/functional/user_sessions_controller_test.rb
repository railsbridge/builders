require File.join(File.dirname(__FILE__), '..', 'test_helper')

class UserSessionsControllerTest < ActionController::TestCase

  context "on GET to new" do
    context 'when not logged in' do
      setup do
        Factory(:user)
        Factory(:active_project)
        get :new
      end

      should_render_template :new
      should_assign_to(:user_session)
      should_show_featured_blurb
    end

    authenticated_user do
      setup { get :new }

      should_redirect_to("User's homepage") { user_path(@user) }
      should_not_assign_to(:user_session)
    end
  end

  context "on PUT to create" do
    context "with valid credentials" do
      setup do
        @user = Factory(:user)
        post :create, :user_session => {:email => @user.email, :password => 'secret'}
      end

      should_assign_to(:user_session)
      should_set_the_flash_to /login successful/i
      should_filter_params :password
      should_redirect_to("User's homepage") {user_path(@user)}
    end

    context "with invalid credentials" do
      setup do
        Factory(:user)
        Factory(:active_project)
        post :create,
             :user_session => {:email => 'nobody', :password => 'badpass'}
      end

      should_assign_to(:user_session)
      should_filter_params :password
      should_render_template :new
      should_show_featured_blurb
    end
  end

  authenticated_user do
    context "on DELETE to :destroy" do
      setup { delete :destroy }

      should_redirect_to('login') { login_path }
      should_set_the_flash_to /logout successful/i

      should "destroy the session" do
        assert_nil UserSession.find
      end
    end
  end
end
