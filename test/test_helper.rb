ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require "authlogic/test_case"
require "webrat"

Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false
end

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit unless include?(RR::Adapters::TestUnit)

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

  # Login helper for integration tests.
  # if your test does not define a @user this will do that for you
  def login
    @user = Factory(:user) unless defined?(@user)

    visit login_path
    fill_in 'Email', :with => @user.email
    fill_in 'Password', :with => 'secret'
    click_button 'LOGIN'
  end

  def featured
    Factory(:user)
    Factory(:active_project)
  end
end
