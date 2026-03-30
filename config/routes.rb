Rails.application.routes.draw do
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