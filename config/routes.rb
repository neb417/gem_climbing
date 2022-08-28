Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/crags', to: 'crags#index'
  get '/crags/new', to: 'crags#new'
  post '/crags', to: 'crags#create'
  get '/crags/:id', to: 'crags#show'
  get '/crags/:id/edit', to: 'crags#edit'
  patch '/crags/:id', to: 'crags#update'
  delete '/crags/:id', to: 'crags#destroy'

  get '/crags/:id/routes', to: 'crag_routes#index'
  get '/crags/:id/routes/new', to: 'crag_routes#new'
  post '/crags/:id/routes', to: 'crag_routes#create'

  get '/routes', to: 'routes#index'
  get '/routes/:id', to: 'routes#show'
  get '/routes/:id/edit', to: 'routes#edit'
  patch '/routes/:id/', to: 'routes#update'
end
