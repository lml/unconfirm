module MaybeConfirm
  class UserSettingsController < ApplicationController

    def index
      if current_user
        @settings = UserSettings.for(current_user)
      end
      settings = @settings? @settings.settings : {}
      respond_to do |format|
        format.json { render json: {:success => true, :settings => settings} }
      end
    end

    def update
      if current_user
        @settings = UserSettings.for(current_user)
      end
      respond_to do |format|
        if @settings and @settings.update_attributes(params[:settings])
          format.json { render json: {:success => true, :message => 'Settings were successfully updated.'} }
        else
          Rails.logger.info(@settings.errors.messages.inspect)
          format.json { render json: {:success => false, :message => 'Unable to update settings.'} }
        end
      end
    end

  end
end
