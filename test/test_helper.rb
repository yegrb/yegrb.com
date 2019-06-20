# typed: false
require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods

  class ActionDispatch::IntegrationTest
    def log_in(user)
      post login_path, params: { session: { email: user.email, password: user.password } }
    end
  end
end
