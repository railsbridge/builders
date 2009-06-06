class Notifier < ActionMailer::Base
  def project_confirmation(project)
    recipients project.contact_email
    subject 'Thank you for signing up.'
    from 'builders@railsbridge.org'
    sent_on Time.now
    body :project => project
  end
end
