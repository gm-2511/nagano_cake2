class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: {
    cannot_start: 0,   # 着手不可
    waiting: 1,        # 製作待ち
    in_production: 2,  # 製作中
    completed: 3       # 製作完了
  }

  def making_status_i18n
    I18n.t("ja.enums.order.order_detail.making_status.#{making_status}") if making_status
  end
end
