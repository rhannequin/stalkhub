Stalkhub::Application.routes.draw do

  # Github auth
  get '/auth/callback', :to => 'sessions#callback'

  root :to => 'application#home'

end
