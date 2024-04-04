Rails.application.routes.draw do
  root "tops#index"
  
  get 'top_index' , to: 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_service', to: 'tops#terms_of_service'
 
  resources :users, only: %i[new create]
  
  resource :profile, only: %i[show edit update]
  get '/users/withdraw', to: 'users#withdraw'
  patch  '/users/withdraw' => 'users#withdraw'

end
