module ProjectsHelper
  def eligible_to_volunteer?
    logged_in? && !ProjectVolunteer.exists?(:user_id => current_user.id, :project_id => @project.id)
  end
end
