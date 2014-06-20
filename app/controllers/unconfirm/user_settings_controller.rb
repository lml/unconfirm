module Unconfirm
  class UserSettingsController < ApplicationController
    include ApplicationHelper

    def show
      respond_to do |format|
        format.json {
          render json: {:success => true,
                        :settings => unconfirm_user_settings} }
      end
    end

    def update
      settings = UserSettings.for(current_user)
      respond_to do |format|
        if not settings.nil? and settings.update_attributes(params[:settings])
          puts "User settings updated. Updating session now"
          update_unconfirm_user_settings! settings
          format.json {
            render json: {:success => true,
                          :message => 'Settings were successfully updated.'} }
        else
          puts "update failed"
          puts settings.errors.messages.inspect
          Rails.logger.info(settings.errors.messages.inspect)
          format.json {
            render json: {:success => false,
                          :message => 'Unable to update settings.'} }
        end
      end
    end

  end
end
