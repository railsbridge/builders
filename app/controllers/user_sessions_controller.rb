class UserSessionsController < ApplicationController
  before_filter :need_to_login, :except => :destroy
  before_filter :require_user, :only => :destroy
  before_filter :featured_project_and_volunteer, :only => :new

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash.now[:notice] = "Login successful!"
      redirect_back_or_default user_path(@user_session.user)
    else
      featured_project_and_volunteer
      render :action => :new
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "Logout successful!"
    redirect_back_or_default login_path
  end

  private

  def need_to_login
    redirect_to(current_user) if logged_in?
    true
  end
end
