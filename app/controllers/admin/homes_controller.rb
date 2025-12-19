class Admin::HomesController < Admin::BaseController
  before_action :authenticate_admin!  # 管理者ログイン必須

  def top
    # 全注文一覧を取得してページネーション
    @orders = Order.includes(:customer, :order_details)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(10)
  end
end
