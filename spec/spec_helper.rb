# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../dummy/config/environment", __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'database_cleaner'

MaybeConfirm::ApplicationController.class_eval do
  include ApplicationHelper
end

