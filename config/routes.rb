Stalkhub::Application.routes.draw do

  resources :stalkings

  # Github OAuth handlers
  get   'sessions/new'
  get   'sessions/create'
  get   'sessions/failure'
  get   '/login',                   :to => 'sessions#new',      :as => :login
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure',            :to => 'sessions#failure'
  get   '/logout',                  :to => 'sessions#logout',   :as => :logout

  get    '/settings',               :to => 'users#show',        :as => :settings
  delete '/account/delete',         :to => 'users#destroy',     :as => :destroy_account
  get    '/about',                  :to => 'application#about', :as => :about

  root :to => 'application#home'

end
