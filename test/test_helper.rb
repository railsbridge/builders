ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'
require "authlogic/test_case" 

class ActiveSupport::TestCase
  include RR::Adapters::TestUnit unless include?(RR::Adapters::TestUnit)

  self.use_transactional_fixtures = true
  self.use_instantiated_fixtures  = false

end
