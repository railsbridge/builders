class UsersController < ApplicationController
  before_filter :require_user, :only => [:edit, :update]
  before_filter :require_owner, :only => [:edit, :update]
  
  def index
    @users = User.hours_per_week_greater_than(0).paginate(:page => params[:page], :per_page => 5)
    
    respond_to do |format|
      format.html      
    end
  end
 
  def show
    @user = User.find(params[:id])
 
    respond_to do |format|
      format.html
    end
  end
 
  def new
    @user = User.new
 
    respond_to do |format|
      format.html
    end
  end
 
  def edit
    @user = User.find(params[:id])
  end
 
  def create
    @user = User.new(params[:user])
 
    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to(edit_user_path(@user)) }        
      else
        format.html { render :action => "new" }
      end
    end
  end
 
  def update
    @user = User.find(params[:id])
 
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  private
  
  def require_owner
    redirect_to current_user unless current_user.id == params[:id].to_i
  end
  
end
