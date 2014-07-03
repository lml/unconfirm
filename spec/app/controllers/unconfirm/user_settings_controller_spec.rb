require 'spec_helper'

module Unconfirm
  describe UserSettingsController, :type => :controller do
    before do
      @user = User.create email: "dummy@dummy.com", handle: "dummy"
      class_eval { include AuthHelper }
    end

    def ensure_close_form_status(status)
      get :show, :id => 0, :format => :json
      body = JSON.parse(response.body)
      expect(body).to include "success"
      expect(body["success"]).to be true
      expect(body).to include "settings"
      if status
        expect(body["settings"]).to include "skip_user_confirmation_dialog_on_close_form"
        expect(body["settings"]["skip_user_confirmation_dialog_on_close_form"]).to be true
      else
        expect(body["settings"]).not_to include "skip_user_confirmation_dialog_on_close_form"
      end
    end

    it 'should not fetch settings for unauthenticated user' do
      get :show, :id => 0, :format => :json
      body = JSON.parse(response.body)
      expect(body).to include "success"
      expect(body["success"]).to be true
      expect(body).to include "settings"
      expect(body["settings"]).not_to include "skip_user_confirmation_dialog_on_close_form"
    end

    it 'should fetch settings for authenticated user' do
      sign_in @user
      ensure_close_form_status false
    end

    it 'should update settings for authenticated user' do
      sign_in @user
      put :update, :id => @user.id, :settings=> {:skip_user_confirmation_dialog_on_close_form => true}, :format => :json
      body = JSON.parse(response.body)
      expect(body).to include "success"
      expect(body["success"]).to be true
      ensure_close_form_status true
    end
  end
end
