Stalkhub::Application.routes.draw do

  resource :users

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  post '/login', :to => 'sessions#login'

  root :to => 'application#home'

end
