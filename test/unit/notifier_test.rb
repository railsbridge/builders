require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  
  def test_project_confirmation
    assert ActionMailer::Base.deliveries.empty?

    project = Factory(:project)
    assert_equal 1, ActionMailer::Base.deliveries.size
    
    assert_sent_email do |email|
      assert_contains email.to, project.contact_email
      email.subject =~ /thank you for signing up/i
      email.body =~ /http:\/\/builders.railsbridge.org\/projects\/#{project.id}\/edit\?access_key=#{project.access_key}/
    end
  end
end
