class ProjectVolunteersController < ApplicationController
  def create
    project_volunteer = ProjectVolunteer.new(params[:project_volunteer])
    project_volunteer.user = current_user
    project_volunteer.role = "volunteer"

    project_volunteer.save!

    flash[:success] = 'Thanks for volunteering.'
    redirect_to current_user
  end
  
  def update
  end
  
  def delete
  end
end
