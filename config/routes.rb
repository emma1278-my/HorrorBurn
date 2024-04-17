Rails.application.routes.draw do
  get 'oauths/oauth'
  get 'oauths/callback'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development? 
  
  root "tops#index"

  get 'top_index' , to: 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'guest_login', to: "users#guest_login"
  get 'movies/search', to: 'movies#search', as: 'movies_search'
  get 'dashboards/index', to: 'dashboards#index', as: 'dashboard_path'
  
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback"
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  
   # 利用規約とプライバシーポリシー
  get 'terms_of_service', to: 'tops#terms_of_service'
  resources :password_resets, only: [:new, :create, :edit, :update]
  # 基礎代謝算出
  resources :metabolism_calculators, only: [:new, :show, :create]
  get 'metabolism_calculators/new', to: 'metabolism_calculators#new', as: 'new_metabolism_calculators'
  post 'metabolism_calculators/show', to: 'metabolism_calculators#show', as: 'show_metabolism_calculators'

  resources :users, only: %i[new create]
  resources :profiles
  resources :dashboards, only: %i[index create show]
  resources :weight_logs, only: %i[create edit update]
  get 'weight_logs', to: 'weight_logs#new'
  # プロフィール
  resource :profile, only: %i[show edit update new create]
  get '/users/withdraw', to: 'users#withdraw'
  patch  '/users/withdraw' => 'users#withdraw'
 
end
