ActiveAdmin.register OrderItem do
  permit_params :order_id, :car_id, :price_at_purchase, :quantity

  index do
    selectable_column
    id_column
    column :order
    column :car
    column :price_at_purchase
    column :quantity
    actions
  end

  filter :order
  filter :car
end
