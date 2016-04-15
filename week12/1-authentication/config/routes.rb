Rails.application.routes.draw do
  resources :users

  root to: 'welcomes#welcome'

  get '/welcome' => 'welcomes#welcome'

  get '/login' => 'logins#new'
  post '/login' => 'logins#create'
  get '/logout' => 'logins#destroy'

  get '/signup' => 'users#new'
  post '/users' => 'users#create'
end
