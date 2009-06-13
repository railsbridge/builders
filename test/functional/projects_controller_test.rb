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
  
  def self.should_process_project_deletions
    should_change 'Project.count', :by => -1
    should_set_the_flash_to /deleted/i
    should_redirect_to('projects index') {projects_path}
  end

  context 'given a project exists' do
    setup { @project = Factory(:project) }

    context 'DELETE to destroy' do
      
      context 'with an invalid access key and nonadmin access' do
        setup { delete :destroy, :id => @project.to_param}
        should_not_change 'Project.count'
        should_set_the_flash_to /access/i
        should_redirect_to('projets show') {project_path}
      end

      admin_user do
        context 'with no access key and admin access' do
          setup { delete :destroy, :id => @project.to_param}
          should_process_project_deletions
        end
      end
      
      context 'with a valid access key' do
        setup { delete :destroy, :id => @project.to_param, :access_key => @project.access_key }
        should_process_project_deletions
      end
    end
  end  
end

    
