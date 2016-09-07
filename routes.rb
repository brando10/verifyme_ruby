Rails.application.routes.draw do
  devise_for :users
  resources :landing do
    member do
      get :landing
      get :redirect
    end
  end
  get "/redirect/receive", to: "landing#receive"

  root 'landing#landing'
end
