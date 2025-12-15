Rails.application.routes.draw do
  namespace :public do
    get 'items/index'
    get 'items/show'
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope module: :public do
    root to: 'homes#top'
    resources :items, only: [:index, :show] # ← この行が重要です
  end
end