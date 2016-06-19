Rails.application.routes.draw do
  root                 'static_pages#home'
  get    'about'    => 'static_pages#about'
  get    'contact'  => 'static_pages#contact'
  get    'features' => 'static_pages#features'
  get    'signup'   => 'users#new'
  get    'login'    => 'sessions#new'
  post   'login'    => 'sessions#create'
  delete 'logout'   => 'sessions#destroy'
  resources :users
  resources :folders
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :bookmarks,           only: [:create, :destroy]
  resources :tags,                only: [:show]
end
