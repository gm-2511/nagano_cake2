class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum status: {
    waiting_payment: 0,  # 入金待ち
    payment_confirmed: 1, # 入金確認
    in_production: 2,     # 製作中
    preparing_shipment: 3,# 発送準備中
    shipped: 4            # 発送済み
  }

  # 支払方法 enum 追加
  enum payment_method: {
    bank_transfer: 0, # 銀行振込
    credit_card: 1    # クレジットカード
  }

  def total_amount
    order_details.sum { |od| od.price * od.amount }
  end

  def shipping_fee
    800  # 固定で800円にする例
  end

  def status_i18n
    I18n.t("enums.order.status.#{status}")
  end

  def payment_method_i18n
    I18n.t("ja.enums.order.payment_method.#{payment_method}") if payment_method
  end
end
