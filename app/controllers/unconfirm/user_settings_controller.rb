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
          update_unconfirm_user_settings! settings
          format.json {
            render json: {:success => true,
                          :message => 'Settings were successfully updated.'} }
        else
          Rails.logger.info(settings.errors.messages.inspect)
          format.json {
            render json: {:success => false,
                          :errors => settings.try(:errors),
                          :message => 'Unable to update settings.'},
                   status: :unprocessable_entity
          }
        end
      end
    end

  end
end
