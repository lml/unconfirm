require 'spec_helper'

module Unconfirm
  describe UserSettingsController, :type => :controller do
    before do
      @user = User.create email: "dummy@dummy.com", handle: "dummy"
      class_eval { include AuthHelper }
    end

    def ensure_close_form_status(status)
      get :index, :format => :json
      body = JSON.parse(response.body)
      assert body.include? "success"
      assert body["success"]
      assert body.include? "settings"
      if status
        assert body["settings"].include? "skip_user_confirmation_dialog_on_close_form"
        assert body["settings"]["skip_user_confirmation_dialog_on_close_form"]
      else
        refute body["settings"].include? "skip_user_confirmation_dialog_on_close_form"
      end
    end

    it 'should not fetch settings for unauthenticated user' do
      get :index, :format => :json
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
      put :update, :id => @user.id, :settings=> {:skip_user_confirmation_dialog_on_close_form => true}, :format => :json
      body = JSON.parse(response.body)
      assert body.include? "success"
      assert body["success"]
      ensure_close_form_status true
    end
  end
end
