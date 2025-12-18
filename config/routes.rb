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

    resources :orders, only: [:index, :show, :update] do
      resources :order_details, only: [:edit, :update] 
    end

    resources :productions, only: [:update]
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
    get 'about' => 'homes#about', as: 'about'

    resources :items, only: [:index, :show]

    # 会員情報の編集・更新・退会確認・退会処理用のルーティング
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :customers, only: [:update]

    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :cart_items, only: [:index, :update, :destroy ,:create] do
      # カートを空にするためのカスタムルーティング（一括削除）
      collection do
        delete 'destroy_all'
      end
    end
  end
end

