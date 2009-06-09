require File.join(File.dirname(__FILE__), '..', 'test_helper')
 
class ProjectsControllerTest < ActionController::TestCase
  context 'GET to index' do
    setup { get :index }
    
    should_respond_with :success
    should_assign_to :projects
  end
 
  context 'GET to new' do
    setup { get :new }
 
    should_respond_with :success
    should_render_template :new
    should_assign_to :project
  end
 
  context 'POST to create' do
    setup do
      post :create, :project => Factory.attributes_for(:project)
      @project = Project.last
    end
    
    should_change 'Project.count', :by => 1
    should_set_the_flash_to /created/i
    should_redirect_to('project show') {project_path(@project)}
    
    should 'send confirmation email' do
      assert_sent_email
    end
  end
 
  context 'GET to show' do
    setup do
      @project = Factory(:project)
      get :show, :id => @project.to_param
    end
    
    should_respond_with :success
    should_render_template :show
    should_assign_to :project
  end
 
  context 'GET to edit' do
    setup { @project = Factory(:project) }
    
    context 'without access key' do
      setup { get :edit, :id => @project.to_param }

      should_respond_with :unauthorized
    end

    context 'with invalid access key' do
      setup { get :edit, :id => @project.to_param, :access_key => 'a_bad_access_key' }

      should_respond_with :not_found
    end

    context 'with valid access key' do
      setup { get :edit, :id => @project.to_param, :access_key => @project.access_key }

      should_respond_with :success
      should_render_template :edit
      should_assign_to(:project) { @project }
    end
  end
 
  context 'PUT to update' do
    setup { @project = Factory(:project) }
    
    context 'without access key' do
      setup { put :update, :id => @project.to_param, :project => Factory.attributes_for(:project) }

      should_respond_with :unauthorized
    end
    
    context 'with invalid access key' do
      setup do 
        put :update, :id => @project.to_param, 
                     :access_key => 'bad', 
                     :project => Factory.attributes_for(:project)
      end
      
      should_respond_with :not_found
    end

    context 'with valid access key' do
      setup do 
        put :update, :id => @project.to_param,
                     :access_key => @project.access_key,
                     :project => Factory.attributes_for(:project)
      end
      
      should_set_the_flash_to /updated/i
      should_assign_to(:project) { @project }
      should_redirect_to('project show') {project_path(@project)}               
    end
  end
  
  context 'given a project exists' do
    setup { @project = Factory(:project) }

    context 'DELETE to destroy' do
      setup { delete :destroy, :id => @project.to_param }
      
      should_eventually "change 'Project.count', :from => 1, :to => 0"
      should_eventually "set_the_flash_to /deleted/i"
      should_eventually "redirect_to('project index') { projects_path }"
    end
  end  
end
