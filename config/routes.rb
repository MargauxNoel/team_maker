Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "teams#index"

  get "teams", to: "teams#index"
  get "teams/new", to: "teams#new"
  post "teams", to: "teams#create"
  get "teams/:id", to: "teams#show", as: "team"
  get "teams/:id/edit", to: "teams#edit", as: "update"
  patch "teams/:id", to: "teams#update"
  delete "teams/:id", to: "teams#destroy", as: "delete"
end
