class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin! # 管理者ログインを必要とする場合

  def index
    @customers = Customer.order(:id).page(params[:page]).per(10)
  end
end
