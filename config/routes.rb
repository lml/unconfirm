MaybeConfirm::Engine.routes.draw do
  resources :user_settings, :only => [:index, :update]
end
