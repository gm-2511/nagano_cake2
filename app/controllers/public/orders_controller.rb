class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
  # 1. 支払方法をセット
  @order = Order.new(payment_method: params[:order][:payment_method])
  
  # 2. 住所の判定とセット
  if params[:order][:select_address] == "0"
    @order.post_code = current_customer.post_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    
  elsif params[:order][:select_address] == "1"
    @address = Address.find(params[:order][:address_id])
    @order.post_code = @address.post_code
    @order.address = @address.address
    @order.name = @address.name
    
  elsif params[:order][:select_address] == "2"
    @order.post_code = params[:order][:post_code]
    @order.address = params[:order][:address]
    @order.name = params[:order][:name]
  end

  # 3. カート商品の取得と計算
  @cart_items = current_customer.cart_items
  @shipping_cost = 800
  @total_amount = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
  @order.total_payment = @total_amount + @shipping_cost
  end

  def thanks
    # 注文完了後は特定のデータを表示する必要がないため、中身は空で問題ありません。
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save
      # 1. カート商品を注文詳細（OrderDetail）に一つずつ保存
      current_customer.cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.order_id = @order.id
      order_detail.item_id = cart_item.item_id
      order_detail.price = cart_item.item.with_tax_price # 購入時の価格を固定
      order_detail.amount = cart_item.amount
      order_detail.making_status = 0 # 製作ステータス初期値
      order_detail.save
      end
        
      # 2. 注文完了後にカートを空にする
      current_customer.cart_items.destroy_all
        
      # 3. サンクスページ（完了画面）へ遷移
      redirect_to thanks_orders_path
    else
    # 失敗した場合は入力画面に戻す
      render :new
    end
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :post_code, :address, :name, :total_payment)
  end
end
