require File.join(File.dirname(__FILE__), '..', 'test_helper')

class PageControllerTest < ActionController::TestCase
  context 'on GET to :index' do
    setup { get :index }
    
    should_respond_with :success
    should_render_template :index
  end

  context 'GET to :show' do
    setup do
      PageController.append_view_path('test/static') unless PageController.view_paths.include?('test/static')
    end

    context 'for invalid static page' do
      setup { get :show, :name => 'bad' }

      should_respond_with :not_found      
    end

    context 'for a valid static page' do
      setup { get :show, :name => 'about' }
      

      should_respond_with :success
      should_render_template :about
    end
  end
end
