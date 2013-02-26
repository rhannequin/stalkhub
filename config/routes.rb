Stalkhub::Application.routes.draw do

  resource :users
  get '/delete/confirm', :to => 'users#destroy_confirm'
  get '/delete',         :to => 'users#destroy'

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  get '/login',  :to => 'sessions#login'
  post '/login', :to => 'sessions#login'
  get '/logout', :to => 'sessions#logout', :as => :logout

  root :to => 'application#home'

end
