Stalkhub::Application.routes.draw do

  resources :stalkings

  resources :users
  get '/settings', :to => 'users#show', :as => :settings

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  get '/login',  :to => 'sessions#login'
  post '/login', :to => 'sessions#login'
  get '/logout', :to => 'sessions#logout', :as => :logout

  root :to => 'application#home'

end
