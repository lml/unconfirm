$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "maybe_confirm/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "maybe_confirm"
  s.version     = MaybeConfirm::VERSION

  s.authors       = ["navilan"]
  s.email         = ["navilan@folds.in"]
  s.summary       = %q{Adds facility for confirmation dialogs with "Don't show this again" settings.}
  s.description   = %q{There are times where the application needs to make confirm users'
                          intentions.  These confirmation interrupts become bothersome overtime as the users
                          get more and more experience with the site.  This gem provides a facility to show
                          the confirmation dialog with affordance for the user to skip the message during
                          future attempts at the same action.}
  s.homepage      = "https://github.com/lml/maybe-confirm"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.18"
  s.add_dependency "jquery-rails"
  s.add_dependency "activerecord-typedstore"

  s.add_development_dependency "bundler", "~> 1.6"
  s.add_development_dependency "rake"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
end
