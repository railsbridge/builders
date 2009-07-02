class ProjectsController < ApplicationController
  verify :params => :access_key, :only => [:edit, :update], 
                                 :render => {:nothing => true, :status => :unauthorized}
  before_filter :get_project, :only => [:edit, :update]

  def index
    @projects = Project.approved
    
    respond_to do |format|
      format.html      
    end
  end
 
  def show
    @project = Project.find(params[:id])
 
    respond_to do |format|
      format.html
    end
  end
 
  def new
    @project = Project.new
 
    respond_to do |format|
      format.html
    end
  end
 
  def edit
    render
  end
 
  def create
    @project = Project.new(params[:project])
 
    respond_to do |format|
      if @project.save
        flash[:success] = 'Project was successfully created.'
        format.html { redirect_to(@project) }        
      else
        format.html { render :action => "new" }
      end
    end
  end
 
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:success] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
 
  def destroy
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.access_key == params[:access_key] || admin?

        @project.destroy
        flash[:success] = 'Project was successfully deleted.'
        format.html { redirect_to(projects_url) }
      else
        flash[:notice] = 'Access Denied'
        format.html { redirect_to project_url(@project) }
      end
    end
  end

  private

  def get_project
    @project = Project.find_by_id_and_access_key!(params[:id], params[:access_key])
  rescue ActiveRecord::RecordNotFound
    render(:nothing => true, :status => :not_found) and return false
  end
end
