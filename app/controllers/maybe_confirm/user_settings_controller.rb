module MaybeConfirm
  class UserSettingsController < ApplicationController
    skip_before_filter :authenticate_user!

    def index
      @settings = UserSettings.for(current_user)
      format.json { render json: {:success => true,  :settings => @settings.settings} }
    end

    def update
      @settings = UserSettings.for(current_user)
      respond_to do |format|
        if @settings.update_attributes(params[:settings])
          format.json { render json: {:success => true, :message => 'Settings were successfully updated.'} }
        else
          Rails.logger.info(@settings.errors.messages.inspect)
          format.json { render json: {:success => false, :message => 'Unable to update settings.'} }
        end
      end
    end
  end
end
