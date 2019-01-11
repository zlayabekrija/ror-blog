Rails.application.routes.draw do
  get 'welcome/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'not_so_welcome/hello'
  get 'not_so_welcome/getout'

  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
