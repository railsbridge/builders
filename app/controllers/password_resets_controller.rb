class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]

  def new
    render
  end

  def create
    @user = User.find_by_email!(params[:email])
    @user.deliver_password_reset_instructions
    
    flash[:success] = 'Instructions to reset your password have been emailed to you.'
    redirect_to root_path
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'No user was found with that email address'
    render :new
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]

    if @user.save
      flash[:success] = 'Password successfully updated'
      redirect_to @user
    else
      flash[:notice] = 'Password not accepted'
      render :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account." +
                       "If you are having issues try copying and pasting the URL " +
                       "from your email into your browser or restarting the " +
                       "reset password process."
      redirect_to root_path
    end
  end
end
