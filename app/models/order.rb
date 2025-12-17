class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  # 注文ステータス
  enum status: {
    waiting_payment: 0,    # 入金待ち
    payment_confirmed: 1,  # 入金確認
    in_production: 2,      # 製作中
    preparing_shipment: 3, # 発送準備中
    shipped: 4             # 発送済み
  }

  # 支払方法
  enum payment_method: {
    bank_transfer: 0,  # 銀行振込
    credit_card: 1     # クレジットカード
  }

  # 注文合計（商品合計）
  def total_amount
    order_details.sum { |od| od.price * od.amount }
  end

  # 送料（テーブルに入ってる値を使う）
  def shipping_fee
    shipping_cost
  end

  # 注文ステータス日本語表示
  def status_i18n
    I18n.t("enums.order.status.#{status}")
  end

  # 支払方法日本語表示
  def payment_method_i18n
    I18n.t("enums.order.payment_method.#{payment_method}")
  end

  # 配送先情報まとめて表示用ヘルパ（任意）
  def shipping_info
    "#{post_code} #{address} #{name}"
  end
end
