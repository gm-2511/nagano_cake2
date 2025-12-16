class AddNameToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :name, :string
    add_index :customers, :name, unique: true
  end
end
