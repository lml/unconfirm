require 'spec_helper'

module MaybeConfirm
  describe UserSettingsController do
    before do
      @user = User.create email: "dummy@dummy.com", handle: "dummy"
      class_eval{ include ApplicationHelper }
    end

    it 'should not fetch settings for unauthenticated user' do
      get :index, {:format => :json}, :use_route => :maybe_confirm
      assert_response 403
    end

    it 'should fetch settings for authenticated user' do
      sign_in @user
      get :index, :use_route => :maybe_confirm, :format => :json
      body = JSON.parse(response.body)
      assert body.include? :success
      assert body[:success]
      assert body.include? :settings
      assert body[:settings].include? :skip_user_confirmation_dialog_on_close_form
      refute body[:settings][:skip_user_confirmation_dialog_on_close_form]
    end
  end
end
