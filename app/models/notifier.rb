class Notifier < ActionMailer::Base
  default_url_options[:host] = 'builders.railsbridge.org'

  def project_confirmation(project)
    recipients project.contact_email
    subject 'Thank you for signing up.'
    from 'RailsBridge Builders <builders@railsbridge.org>'
    sent_on Time.now
    body :project => project
  end
  
  def password_reset_instructions(user)
    subject 'Password Reset Instructions'
    from 'Railbridge Builders <builders@railsbridge.org>'
    recipients user.email
    sent_on Time.now
    body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end
end
