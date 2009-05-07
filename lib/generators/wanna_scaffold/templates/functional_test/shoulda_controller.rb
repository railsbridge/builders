require 'test_helper'
 
class <%= controller_class_name %>ControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :<%= table_name %>
  end
 
  context 'GET to new' do
    setup { get :new }
 
    should_respond_with :success
    should_render_template :new
    should_assign_to :<%= file_name %>
  end
 
  context 'POST to create' do
    setup do
      post :create, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
      @<%= file_name %> = <%= class_name %>.last
    end
    
    should_change '<%= class_name %>.count', :by => 1
    should_set_the_flash_to /created/i
    should_redirect_to('<%= file_name %> show') {<%= file_name %>_path(@<%= file_name %>)}
  end
 
  context 'GET to show' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      get :show, :id => @<%= file_name %>.to_param
    end
    
    should_respond_with :success
    should_render_template :show
    should_assign_to :<%= file_name %>
  end
 
  context 'GET to edit' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      get :edit, :id => @<%= file_name %>.to_param
    end
    
    should_respond_with :success
    should_render_template :edit
    should_assign_to :<%= file_name %>
  end
 
  context 'PUT to update' do
    setup do
      @<%= file_name %> = Factory(:<%= file_name %>)
      put :update, :id => @<%= file_name %>.to_param, :<%= file_name %> => Factory.attributes_for(:<%= file_name %>)
    end
    
    should_set_the_flash_to /updated/i
    should_redirect_to('<%= file_name %> show') {<%= file_name %>_path(@<%= file_name %>)}
  end
  
  context 'given a <%= file_name %> exists' do
    setup { @<%= file_name %> = Factory(:<%= file_name %>) }

    context 'DELETE to destroy' do
      setup { delete :destroy, :id => @<%= file_name %>.to_param }
      
      should_change '<%= class_name %>.count', :from => 1, :to => 0
      should_set_the_flash_to /deleted/i
      should_redirect_to('<%= file_name %> index') { <%= table_name %>_path }
    end
  end  
end