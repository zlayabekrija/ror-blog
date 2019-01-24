Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'not_so_welcome/hello'
  get 'not_so_welcome/getout'

  resources :articles do
    resources :comments
  end
  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  root 'welcome#index'
end
