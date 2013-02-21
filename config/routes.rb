Stalkhub::Application.routes.draw do

  get "users/new"
  get "users/create"

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  root :to => 'application#home'

end
