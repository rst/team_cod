Rails.application.routes.draw do
  root to: 'searches#show'
  devise_for :users
  resources :users
  resource :admin
  resource :search
  resources :contact
  resources :listings, controller: 'events', as: 'events' do
    collection do
      get :search
      get :expired
    end
  end
end
