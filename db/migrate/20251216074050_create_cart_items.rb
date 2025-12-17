class CreateCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :cart_items do |t|
      t.integer :customer_id, null: false # NOT NULL に修正
      t.integer :item_id, null: false     # NOT NULL に修正
      t.integer :amount, null: false, default: 0 # NOT NULL かつデフォルト値 0 に修正

      t.timestamps
    end
  end
end
