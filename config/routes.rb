Rails.application.routes.draw do
  # ===== 管理者用ルート =====
  namespace :admin do
    root to: 'homes#top'

    resources :items
    resources :products, only: [:index, :show, :new, :create, :edit, :update, :destroy]
    resources :genres, only: [:index, :create, :edit, :update]

    resources :customers, only: [:index, :show, :edit, :update] do
      resources :orders, only: [:index] # 会員ごとの注文一覧
    end

    resources :orders, only: [:show, :update] # 注文詳細・ステータス更新
    resources :productions, only: [:update]   # 製作ステータス更新
  end

  # ===== 顧客用 Devise =====
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  # ===== 管理者用 Devise =====
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # ===== 顧客側ルート =====
  scope module: :public do
    root to: 'homes#top'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy] do
      # カートを空にするためのカスタムルーティング（一括削除）
      collection do
        delete 'destroy_all'
      end
  end
end
