Rails.application.routes.draw do
  get 'foods/index'
  root "welcome#index"
  resources :foods, only: [:index]
end
