class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order, only: [:show, :update]
  before_action :set_customer, only: [:customer_orders]

  def index
    if params[:customer_id]
      # 会員詳細から来た場合、その顧客の注文一覧
      @customer = Customer.find(params[:customer_id])
      @orders = @customer.orders
                        .includes(:order_details)
                        .order(created_at: :desc)
                        .page(params[:page])
                        .per(10)
    else
      # 全注文一覧
      @orders = Order.includes(:customer, :order_details)
                    .order(created_at: :desc)
                    .page(params[:page])
                    .per(10)
    end
end

  def show
    # 注文と注文詳細、関連商品をまとめて読み込む
    @order = Order.includes(order_details: :item).find(params[:id])
  end

  def update
    if @order.update(order_params)
      redirect_to admin_order_path(@order), notice: "注文ステータスを更新しました"
    else
      redirect_to admin_order_path(@order), alert: "更新に失敗しました"
    end
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
    unless @order
      redirect_to admin_orders_path, alert: "注文が見つかりません"
    end
  end

  def order_params
    params.require(:order).permit(:status)
  end

  def customer_orders
    @customer = Customer.find(params[:customer_id])
   @orders = @customer.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

end
