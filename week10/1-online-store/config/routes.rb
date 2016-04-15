Rails.application.routes.draw do
  #resources :brands
  get '/brands', to: 'brands#index'

  get '/brands/count', to: 'brands#count'
  get '/brands/:index', to: 'brands#show'
  get '/brands/range/:id', to: 'brands#range' #BrandsControler method range
  get '/brands/range/:id/:count', to: 'brands#from'

  post '/brands/new', to: 'brands#create'
  put '/brands/:id', to: 'brands#update'

  delete '/brands/:id', to: 'brands#destroy'


  get '/categories', to: 'categories#index'
  get '/categories/count', to: 'categories#count'
  get '/categories/:index', to: 'categories#show'
  get '/categories/range/:id', to: 'categories#range'
  get '/categories/range/:id/:count', to: 'categories#from'
  post '/categories/new', to: 'categories#create'
  put '/categories/:id', to: 'categories#update'
  delete '/categories/:id', to: 'categories#destroy'

  get '/products', to: 'products#index'
  get '/products/count', to: 'products#count'
  get '/products/:index', to: 'products#show'
  get '/products/range/:id', to: 'products#range'
  get '/products/range/:id/:count', to: 'products#from'
  post '/products/new', to: 'products#create'
  put '/products/:id', to: 'products#update'
  delete '/products/:id', to: 'products#destroy'

  get '/search/:type/:slug', to: 'searches#search_by_type'
  get '/search/:type/:property/:slug', to: 'searches#search_by_type_and_property'
  
end
