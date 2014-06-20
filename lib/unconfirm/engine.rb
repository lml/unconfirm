module Unconfirm
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
    initializer 'unconfirm.assets.precompile'do |app|
      app.config.assets.precompile += ['unconfirm']
    end
  end
end
