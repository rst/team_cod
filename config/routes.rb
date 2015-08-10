Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :contact
  resources :listings, controller: 'events', as: 'events' do
    collection do
      get :search
      get :expired
      get :expired_matching_pattern
      get :index_matching_pattern
    end
  end
end
