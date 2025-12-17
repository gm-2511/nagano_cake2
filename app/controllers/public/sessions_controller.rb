class Public::SessionsController < Devise::SessionsController
    before_action :customer_state, only: [:create]

    # ... (省略)
  
    private
    # アクティブであるかを判断するメソッド
    def customer_state
      # 【処理内容1】 入力されたemailからアカウントを1件取得
      customer = Customer.find_by(email: params[:customer][:email])
      # 【処理内容2】 アカウントを取得できなかった場合、このメソッドを終了する
      return if customer.nil?
      # 【処理内容3】 取得したアカウントのパスワードと入力されたパスワードが一致していない場合、このメソッドを終了する
      return unless customer.valid_password?(params[:customer][:password])
  
      # 【処理内容4】 アクティブでない会員に対する処理
      if customer.is_active == false
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_customer_registration_path
      end
    end
end
