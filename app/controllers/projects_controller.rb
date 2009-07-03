class ProjectsController < ApplicationController
  before_filter :authorize, :only => [:edit, :update]
  
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

        @project.cancel
        flash[:success] = 'Project was successfully cancelled.'
        format.html { redirect_to(projects_url) }
      else
        flash[:notice] = 'Access Denied'
        format.html { redirect_to project_url(@project) }
      end
    end
  end

  private

  def authorize
    @project = Project.find(params[:id])
    
    unless @project.authorized?(params[:access_key].blank? ? current_user : params[:access_key])
      render(:nothing => true, :status => :unauthorized) and return false
    end
  end
end
