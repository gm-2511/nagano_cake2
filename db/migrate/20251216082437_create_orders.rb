class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true  # 会員ID
      t.string :post_code, null: false                        # 配送先郵便番号
      t.string :address, null: false                          # 配送先住所
      t.string :name, null: false                             # 配送先宛名
      t.integer :shipping_cost, null: false, default: 800     # 送料
      t.integer :total_payment, null: false                   # 請求額
      t.integer :payment_method, null: false                  # 支払い方法(enum用)
      t.integer :status, null: false, default: 0              # 注文ステータス(enum用)

      t.timestamps                                            # created_at, updated_at
    end
  end
end
