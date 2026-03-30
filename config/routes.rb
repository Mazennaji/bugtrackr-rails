Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount ActionCable.server => "/cable"

  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login",    to: "auth#login"
      post "auth/refresh",  to: "auth#refresh"

      resources :notifications, only: [:index] do
        collection do
          get  :unread
          patch :mark_all_read
        end
        member do
          patch :mark_read
        end
      end

      namespace :admin do
        get  "dashboard", to: "dashboard#index"
        resources :users, only: [:index, :show, :destroy] do
          member do
            patch :ban
            patch :unban
            patch :make_admin
          end
        end
      end

      resources :teams do
        resources :team_members, only: [:index, :create, :update, :destroy]
        resources :projects do
          member do
            get :board
          end
          resources :columns, only: [:index, :create, :update, :destroy]
          resources :issues do
            member do
              patch :move
            end
            resources :comments, only: [:index, :create, :destroy]
          end
        end
      end
    end
  end
end