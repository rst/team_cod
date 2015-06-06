Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resource :events do
    get :search
  end
end
