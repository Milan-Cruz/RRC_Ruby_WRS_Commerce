Rails.application.routes.draw do
  # Root path
  root "home#index"

  # Categories
  resources :categories, only: [:index, :show]

  # Cars
  get "cars", to: "cars#index"

  resources :cars, only: [:index, :show] do
    collection do
      get "search"
    end
  end

  # User profile
  get "profile", to: "users#show", as: :user_profile

  # Devise routes for users and admin users
  devise_for :users, controllers: {
                       sessions: "devise/sessions",
                     }, sign_out_via: [:delete, :get]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest", to: "rails/pwa#manifest", as: :pwa_manifest
end
