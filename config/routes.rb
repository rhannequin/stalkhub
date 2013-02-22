Stalkhub::Application.routes.draw do

  resource :users

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  root :to => 'application#home'

end
