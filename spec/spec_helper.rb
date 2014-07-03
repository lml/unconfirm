ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)
require 'rspec/rails'

#Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
end

module AuthHelper
  @@user = nil

  def current_user
    @@user
  end

  def sign_in(user)
    @@user = user
  end

  def sign_out
    @@user = nil
  end
end

ActionController::Base.send :include, AuthHelper
