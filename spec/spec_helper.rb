# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'database_cleaner'

MaybeConfirm::ApplicationController.class_eval do
  include ApplicationHelper
end

def setup_model_spec
  @user = User.create email: "dummy@dummy.com", handle: "dummy"
end

def setup_controller_spec
  class_eval {include ApplicationHelper}
  setup_model_spec
end
