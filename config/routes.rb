Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/crags', to: 'crags#index'
  get 'crags/new', to: 'crags#new'
  get '/crags/:id', to: 'crags#show'
  get '/crags/:id/routes', to: 'crag_routes#index'


  get '/routes', to: 'routes#index'
  get '/routes/:id', to: 'routes#show'
end
