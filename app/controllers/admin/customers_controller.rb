class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin! # 管理者ログインを必要とする場合
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.order(:id).page(params[:page]).per(10)
  end

  def show
    
  end

  # 会員情報編集
  def edit
  end

  # 更新処理
  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報を更新しました"
    else
      render :edit
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :first_name, :last_name,
      :first_name_kana, :last_name_kana,
      :postal_code, :address, :telephone_number,
      :email, :is_active
    )
  end

end
