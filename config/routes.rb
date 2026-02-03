Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  # root "posts#index"

  namespace :v1 do
    resources :patients, only: [ :index, :show, :create ]
    resources :treatment_plans, only: [ :index, :create, :update ]
    resources :medication_refill_orders, only: [ :index, :show, :create, :update ]
  end
end
