Rails.application.routes.draw do
  #resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/", to: "users#index"
  get "/register", to: "users#new"
  get "/login", to: "users#login"
  resources :tasks, only: [:destroy]
  post "register", to: "users#create"
  post "/login", to: "users#new_session"
  get "tasks/new" , to:"tasks#new"
  get "/users/logout", to: "users#logout"
  post "/tasks/new", to: "tasks#create"
  get "/tasks/complete/:task_id", to: "tasks#complete"
end
