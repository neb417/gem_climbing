Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/crags', to: 'crags#index'
  get '/crags/:id', to: 'crags#show'


  get '/routes', to: 'routes#index'
  get '/routes/:id', to: 'routes#show'
end
