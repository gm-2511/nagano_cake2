class RenameAddreddToAddressInCustomers < ActiveRecord::Migration[6.1]
  def change
    rename_column :customers, :addredd, :address
  end
end
