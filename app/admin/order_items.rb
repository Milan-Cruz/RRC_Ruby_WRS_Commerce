ActiveAdmin.register OrderItem do
  # Allow admin to manage these attributes
  permit_params :order_id, :car_id, :price_at_purchase, :quantity

  # Index page customization
  index do
    selectable_column
    id_column
    column :order do |item|
      link_to "Order ##{item.order.id}", admin_order_path(item.order)
    end
    column :car do |item|
      link_to "#{item.car.make} #{item.car.model}", admin_car_path(item.car)
    end
    column :price_at_purchase do |item|
      number_to_currency(item.price_at_purchase)
    end
    column :quantity
    column "Total" do |item|
      number_to_currency(item.price_at_purchase * item.quantity)
    end
    actions
  end

  # Filters for easy navigation
  filter :order, as: :select, collection: proc { Order.all.map { |o| ["Order ##{o.id}", o.id] } }
  filter :car, as: :select, collection: proc { Car.all.map { |c| ["#{c.make} #{c.model}", c.id] } }
  filter :price_at_purchase
  filter :quantity
  filter :created_at

  # Show page customization
  show do
    attributes_table do
      row :id
      row :order do |item|
        link_to "Order ##{item.order.id}", admin_order_path(item.order)
      end
      row :car do |item|
        link_to "#{item.car.make} #{item.car.model}", admin_car_path(item.car)
      end
      row :price_at_purchase do |item|
        number_to_currency(item.price_at_purchase)
      end
      row :quantity
      row "Total" do |item|
        number_to_currency(item.price_at_purchase * item.quantity)
      end
      row :created_at
      row :updated_at
    end
  end

  # Form customization
  form do |f|
    f.inputs "Order Item Details" do
      f.input :order, as: :select, collection: Order.all.map { |o| ["Order ##{o.id}", o.id] }, include_blank: false
      f.input :car, as: :select, collection: Car.all.map { |c| ["#{c.make} #{c.model}", c.id] }, include_blank: false
      f.input :price_at_purchase
      f.input :quantity
    end
    f.actions
  end
end
