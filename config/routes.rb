Stalkhub::Application.routes.draw do

  resource :users

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  get '/login',  :to => 'sessions#login'
  post '/login', :to => 'sessions#login'

  root :to => 'application#home'

end
