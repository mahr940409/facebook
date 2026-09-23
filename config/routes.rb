Rails.application.routes.draw do
  get "profiles/show"
  get "me/index"
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
  resources :friends, controller: "friends", only: [ :index, :show, :destroy, :create, :update ] do
    resources :posts, only: [ :show ]
  end
  resources :posts, only: [ :index, :destroy, :create, :update, :show, :edit ] do
    resources :comments, only: [ :index, :destroy, :create, :update, :edit ]
    resources :likes, only: [ :index, :destroy, :create ]
    resource :likes, only: [] do
      get "/count", to: "likes#count"
    end
  end

  resources :users, only: [] do
    resources :friends, only: [ :index ]
  end

  resource :users, only: [] do
      resource :me,
           controller: "me",
           only: [ :show, :new, :create, :edit, :update ]
  end

  resource :me, only: [], module: "me" do
    resources :friends, only: [ :index ]
  end

  resources :groupchats, only: [ :new, :show, :create, :destroy, :index ] do
    resources :messages, only: [ :index, :show, :create, :edit, :update, :destroy ]
  end
end
