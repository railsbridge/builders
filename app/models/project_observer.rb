class ProjectObserver < ActiveRecord::Observer
  def after_create(project)
    Notifier.deliver_project_confirmation(project)
  end
end
