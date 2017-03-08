Rails.application.routes.draw do
  resources :shipments
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "shipments#index"
end