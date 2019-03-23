Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#index'
  get '/contact', to: 'home#index'
  get '/login', to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :likes, only: [:create]
      resources :users, only: [:index] do
        collection do
          get :like_users, :be_liked_users
        end
      end
      resources :tasks, only: [:index, :create, :update]
      post 'login_or_create', to: 'logins#login_or_create'
    end
  end
end
