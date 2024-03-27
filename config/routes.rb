Rails.application.routes.draw do
  root "tops#index"

  get 'top_index' , to: 'tops#index'
  get 'privacy_policy', to: 'tops#privacy_policy'
  get 'terms_of_service', to: 'tops#terms_of_service'
end
