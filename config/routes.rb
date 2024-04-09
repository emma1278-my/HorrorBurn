Rails.application.routes.draw do
  get 'movies/search'
  get 'movies/show'
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development? 
  
  root "tops#index"

  get 'top_index' , to: 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get "guest_login", to: "users#guest_login"
 
   # 利用規約とプライバシーポリシー
  get 'terms_of_service', to: 'tops#terms_of_service'
  resources :password_resets, only: [:new, :create, :edit, :update]
  # 基礎代謝算出
  resources :metabolism_calculators, only: [:new, :show, :create]
  get 'metabolism_calculators/new', to: 'metabolism_calculators#new', as: 'new_metabolism_calculators'
  post 'metabolism_calculators/show', to: 'metabolism_calculators#show', as: 'show_metabolism_calculators'

  resources :users, only: %i[new create]
  resources :profiles
  # プロフィール
  resource :profile, only: %i[show edit update new create]
  get '/users/withdraw', to: 'users#withdraw'
  patch  '/users/withdraw' => 'users#withdraw'


end
