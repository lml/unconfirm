Rails.application.routes.draw do
  scope module: 'unconfirm' do
    resources :user_settings, :only => [:show, :update], path: '/unconfirm/user_settings'
  end
end
