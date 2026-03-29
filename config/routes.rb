Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login",    to: "auth#login"
      post "auth/refresh",  to: "auth#refresh"

      resources :teams do
        resources :team_members, only: [:index, :create, :update, :destroy]
        resources :projects do
          member do
            get :board
          end
        end
      end
    end
  end
end