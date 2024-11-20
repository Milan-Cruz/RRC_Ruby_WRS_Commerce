Rails.application.routes.draw do
  get "cars/index"
  get "categories/index"
  # root "pages#home"

  # Define the root path route ("/")
  root "home#index"

  get "home/index"
  # Active Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for users with sign_out_via specified
  devise_for :users, controllers: {
                       sessions: "devise/sessions",
                     }, sign_out_via: [:delete, :get]

  # profile
  get "profile", to: "users#show", as: :user_profile
  # categories
  get "categories", to: "categories#index"
  # search
  get "cars", to: "cars#index"
  get "search", to: "cars#search"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
