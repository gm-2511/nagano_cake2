class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_order
  before_action :set_order_detail, only: [:edit, :update]

  def edit
  end

  def update
    if @order_detail.update(order_detail_params)
      redirect_to admin_order_path(@order), notice: "更新しました"
    else
      render :edit
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def set_order_detail
    @order_detail = @order.order_details.find(params[:id])
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
