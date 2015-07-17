Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resource :admin
  resources :contact
  resources :listings, controller: 'events', as: 'events' do
    collection do
      get :search
      get :expired
    end
  end
end
