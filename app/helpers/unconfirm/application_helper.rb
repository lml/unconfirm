module Unconfirm
  module ApplicationHelper

    def unconfirm_user_settings!
      update_from_model
    end

    def unconfirm_user_settings
      if not session.include? :unconfirm_user_setttings
        update_from_model
      end
      session[:unconfirm_user_settings]
    end

    def update_unconfirm_user_settings!(settings_model)
      update_from_model(settings_model)
    end

    private

    def update_from_model(settings_model=nil)
      settings_model ||= UserSettings.for(current_user)
      puts "Model initialized"
      if not settings_model.nil?
        settings = settings_model.truthy_settings
      end
      puts "Settings initialized"
      settings ||= {}
      puts settings
      session[:unconfirm_user_settings] = settings
      puts "Session updated"
    end

  end
end
