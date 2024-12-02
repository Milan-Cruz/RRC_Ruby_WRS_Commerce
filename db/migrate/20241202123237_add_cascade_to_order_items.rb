class AddCascadeToOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :order_items, :orders
    add_foreign_key :order_items, :orders, on_delete: :cascade
  end
end
