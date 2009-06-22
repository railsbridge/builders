require File.join(File.dirname(__FILE__), '..', 'test_helper')

class NotifierTest < ActionMailer::TestCase
  tests Notifier
  
  def setup
    assert ActionMailer::Base.deliveries.empty?
  end
  
  def test_project_confirmation
    project = Factory(:project)
    assert_equal 1, ActionMailer::Base.deliveries.size
    
    email = ActionMailer::Base.deliveries.first
    assert_contains email.to, project.contact_email
    assert_contains email.from, /builders@railsbridge.org/i
    assert_contains email.bcc, /builders@railsbridge.org/i
    assert_match /thank you for signing up/i, email.subject
    assert_match /http:\/\/builders.railsbridge.org\/projects\/#{project.id}\/edit\?access_key=#{project.access_key}/,
                email.body
  end

  def test_password_reset_instructions
    user = Factory(:user)
    email = Notifier.deliver_password_reset_instructions(user)

    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_contains email.to, user.email
    assert_contains email.from, /builders@railsbridge.org/i
    assert_match /password reset instructions/i, email.subject
    assert_match /http:\/\/builders.railsbridge.org\/password_resets\/#{user.perishable_token}\/edit/, email.body
  end
end
