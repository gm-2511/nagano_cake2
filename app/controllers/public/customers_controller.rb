class Public::CustomersController < ApplicationController
    before_action :authenticate_customer!

    # 顧客のマイページ
    def show
      @customer = current_customer
    end
  
    # 顧客の登録情報編集画面
    def edit
      @customer = current_customer
    end
  
    # 顧客の登録情報更新
    def update
      @customer = current_customer
      if @customer.update(customer_params)
        redirect_to my_page_path, notice: "登録情報を更新しました。"
      else
        render :edit
      end
    end
  
    # 顧客の退会確認画面
    def unsubscribe
      # 表示のみ
    end
  
    # 顧客の退会処理 (ステータスの更新)
    def withdraw
      @customer = current_customer
      # is_activeカラムをfalseに更新して論理削除とする
      @customer.update(is_active: false)
      # セッションを破棄してログアウトさせる
      reset_session
      flash[:notice] = "退会処理を実行いたしました。"
      redirect_to root_path
    end
  
    private
  
    def customer_params
      params.require(:customer).permit(
        :last_name, 
        :first_name, 
        :last_name_kana, 
        :first_name_kana, 
        :post_code, 
        :address, 
        :telephone_number, 
        :email
      )
    end
end
