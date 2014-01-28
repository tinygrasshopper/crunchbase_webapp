CrunchbaseWebapp::Application.routes.draw do
  root 'search#index'
  resources :companies, only: [:show]
  resources :products, only: [:show]
end
