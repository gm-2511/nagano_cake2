class AddConstraintAndIndexToItems < ActiveRecord::Migration[6.1]
  def change
    change_column_null :items, :genre_id, false
    
    add_index :items, :genre_id
  end
end
