module ProjectsHelper
  def eligible_to_volunteer?
    logged_in? && @project.accepting_volunteers?(current_user)
  end
end
