Rails.application.routes.draw do
  namespace :admin do
    get 'customers/index'
  end
  namespace :admin do
    get 'genres/edit'
  end
  # 顧客
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # 管理者
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ===== 顧客側 =====
  scope module: :public do
    root to: 'homes#top'
    resources :items, only: [:index, :show]
  end

  # ===== 管理者側 =====
  namespace :admin do
    root to: 'homes#top'
    resources :items
    resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
  end

end

