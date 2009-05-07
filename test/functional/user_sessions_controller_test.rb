require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  
  context "on GET to new" do
    setup { get :new }

    should_respond_with :success
    should_render_template :new
    should_assign_to(:user_session)
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
      setup { post :create, :user_session => {:email => 'nobody', :password => 'badpass'} }

      should_assign_to(:user_session)
      should_set_the_flash_to /login failed/i
      should_filter_params :password
      should_render_template :new
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
