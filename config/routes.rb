Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :events do
    collection do
      get :show
      get :search
    end
  end
end
