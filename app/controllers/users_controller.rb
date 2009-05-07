class UsersController < ApplicationController
  def index
    @users = User.find :all
    
    respond_to do |format|
      format.html      
    end
  end
 
  def show
    @user = User.find params[:id]
 
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
    @user = User.find params[:id]
  end
 
  def create
    @user = User.new params[:user]
 
    respond_to do |format|
      if @user.save
        flash[:success] = 'User was successfully created.'
        format.html { redirect_to(@user) }        
      else
        format.html { render :action => "new" }
      end
    end
  end
 
  def update
    @user = User.find params[:id]
 
    respond_to do |format|
      if @user.update_attributes(params[:user])
        flash[:success] = 'User was successfully updated.'
        format.html { redirect_to(@user) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
 
  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = 'User was successfully deleted.'
 
    respond_to do |format|
      format.html { redirect_to(users_url) }
    end
  end
end