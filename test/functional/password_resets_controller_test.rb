require File.join(File.dirname(__FILE__), '..', 'test_helper')

class PasswordResetsControllerTest < ActionController::TestCase

  context 'on GET to new' do
    setup { get :new }

    should_respond_with :success
    should_render_template :new
  end

  context 'on POST to create' do
    context 'for valid email' do
      setup do
        @user = Factory(:user)
        post :create, :email => @user.email
      end

      should_assign_to(:user) { @user }
      should_set_the_flash_to /instructions to reset your password have been emailed to you/i
      should_redirect_to('home page') { root_path }
    end

    context 'for invalid email' do
      setup { post :create, :email => 'drhorrible@evilleagueofevil.com' }
      
      should_not_assign_to(:user)
      should_render_template :new
      should_set_the_flash_to /no user was found with that email address/i
    end
  end

  context 'on GET to edit' do
    context 'with a valid token' do
      setup do
        @user = Factory(:user)
        get :edit, :id => @user.perishable_token
      end

      should_respond_with :success
      should_render_template :edit
      should_assign_to(:user) { @user }
    end

    context 'with an invalid token' do
      setup { get :edit, :id => 'something_evil' }
      
      should_not_assign_to(:user)
      should_redirect_to('home page') { root_path }
      should_set_the_flash_to /sorry, but we could not locate your account/i
    end
  end

  context 'on PUT to update' do
    setup { @user = Factory(:user) }
    context 'with valid password' do
      setup do 
        put :update, :id => @user.perishable_token,
                     :user => {:password => '123pass', :password_confirmation => '123pass' } 
      end  

      should_set_the_flash_to /password successfully updated/i
      should_redirect_to("user's home page") { user_path(@user) }
    end

    context 'with invalid password' do
      setup do 
        put :update, :id => @user.perishable_token,
                     :user => {:password => '123pass', :password_confirmation => '456pass' }
      end
      
      should_set_the_flash_to /password not accepted/i
      should_respond_with :success
      should_render_template :edit
    end
  end
end
