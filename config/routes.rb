Rails.application.routes.draw do
  root "tops#index"
  
  get 'top_index' , to: 'tops#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy_policy', to: 'tops#privacy_policy'

   # 利用規約とプライバシーポリシー
  get 'terms_of_service', to: 'tops#terms_of_service'

  # 基礎代謝算出
  get 'metabolism_calculators/new', to: 'metabolism_calculators#new', as: 'new_metabolism_calculators'
  post 'metabolism_calculators/show', to: 'metabolism_calculators#show'

  resources :users, only: %i[new create]

  # プロフィール
  resource :profile, only: %i[show edit update]
  get '/users/withdraw', to: 'users#withdraw'
  patch  '/users/withdraw' => 'users#withdraw'

end
