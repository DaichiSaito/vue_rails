Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  mount ActionCable.server => '/cable'
  get '/about', to: 'home#index'
  get '/contact', to: 'home#index'
  get '/login', to: 'home#index'
  get '/login_development', to: 'home#index'
  get '/login_as/:user_id', to: 'development/sessions#login_as'
  get '/chatrooms', to: 'home#index'
  get '/chatrooms/:id', to: 'home#index'
  # get '/chatrooms/:chatroom_id/messages', to: 'home#index'
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :likes, only: [:create]
      resources :chatrooms, only: [:index] do
        resources :messages, only: [:index, :create], module: :chatrooms
      end

      resources :messages, only: [:index, :create] do
        collection do
          get :unread
        end
      end

      resources :users, only: [:index] do
        collection do
          get :like_users, :be_liked_users, :matching_users
        end
      end
      resources :tasks, only: [:index, :create, :update]
      post 'login_or_create', to: 'logins#login_or_create'
    end
  end
end
