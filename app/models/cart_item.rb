class CartItem < ApplicationRecord
  # integer 型でIDを保持していますが、Railsに belongs_to で関連付けることを伝えます。
  belongs_to :customer
  belongs_to :item

  # 1. 数量のバリデーション
  validates :amount, presence: true, numericality: { greater_than: 0 }

  # 2. 重複登録の防止
  # customer_id ごとに item_id が重複しないようにする
  validates :item_id, uniqueness: { scope: :customer_id }
  
  def subtotal
    item.with_tax_price * amount
  end
end
