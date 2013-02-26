Stalkhub::Application.routes.draw do

  resource :users

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  get '/login',  :to => 'sessions#login'
  post '/login', :to => 'sessions#login'
  get '/logout', :to => 'sessions#logout', :as => :logout

  root :to => 'application#home'

end
