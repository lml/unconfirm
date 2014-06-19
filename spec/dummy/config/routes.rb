Rails.application.routes.draw do

  mount MaybeConfirm::Engine => "/maybe_confirm"
end
