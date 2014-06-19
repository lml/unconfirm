require 'spec_helper'

module MaybeConfirm
  describe UserSettingsController do
    before do
      setup_controller_spec
    end

    def ensure_close_form_status(status)
      get :index, :use_route => :maybe_confirm, :format => :json
      body = JSON.parse(response.body)
      assert body.include? "success"
      assert body["success"]
      assert body.include? "settings"
      assert body["settings"].include? "skip_user_confirmation_dialog_on_close_form"
      if status
        assert body["settings"]["skip_user_confirmation_dialog_on_close_form"]
      else
        refute body["settings"]["skip_user_confirmation_dialog_on_close_form"]
      end
    end

    it 'should not fetch settings for unauthenticated user' do
      get :index, :format => :json, :use_route => :maybe_confirm
      body = JSON.parse(response.body)
      assert body.include? "success"
      assert body["success"]
      assert body.include? "settings"
      refute body["settings"].include? "skip_user_confirmation_dialog_on_close_form"
    end

    it 'should fetch settings for authenticated user' do
       sign_in @user
       ensure_close_form_status false
    end

    it 'should update settings for authenticated user' do
      sign_in @user
      post :update, :settings=> {:skip_user_confirmation_dialog_on_close_form => true}, :use_route => :maybe_confirm, :format => :json
      body = JSON.parse(response.body)
      assert body.include? "success"
      assert body["success"]
      ensure_close_form_status true
    end

  end
end
