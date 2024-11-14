Rails.application.routes.draw do
  get "home/index"
  # Active Admin routes
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Devise routes for users with sign_out_via specified
  devise_for :users, controllers: {
                       sessions: "devise/sessions",
                     }, sign_out_via: [:delete, :get]

  get "profile", to: "users#show", as: :user_profile

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Define the root path route ("/")
  root "home#index"
end
