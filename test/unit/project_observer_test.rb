require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ProjectObserverTest < ActiveSupport::TestCase

  context 'after project creation' do
    should 'send email' do
      project = Factory.build(:project)
      stub(Notifier, :method_missing)
      stub(Notifier, :deliver_project_confirmation).with(project)
      project.save
 
      assert_received(Notifier) { |notifier| notifier.deliver_project_confirmation(project) }
    end
  end
end
