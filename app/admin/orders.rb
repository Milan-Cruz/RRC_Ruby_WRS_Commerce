ActiveAdmin.register Order do
  # Allow admin to manage these attributes
  permit_params :user_id, :total_price, :status, :gst, :pst, :hst

  # Index page customization
  index do
    selectable_column
    id_column
    column :user do |order|
      link_to order.user.name, admin_user_path(order.user)
    end
    column :total_price do |order|
      number_to_currency(order.total_price)
    end
    column :gst do |order|
      number_to_currency(order.gst)
    end
    column :pst do |order|
      number_to_currency(order.pst)
    end
    column :status
    column :created_at
    actions
  end

  # Filters for easy navigation
  filter :user, as: :select, collection: proc { User.all.map { |u| [u.name, u.id] } }
  filter :status, as: :select, collection: ["new", "paid", "shipped"]
  filter :created_at

  # Scopes for filtering orders by status
  scope :all, default: true
  scope("New Orders") { |orders| orders.where(status: "new") }
  scope("Paid Orders") { |orders| orders.where(status: "paid") }
  scope("Shipped Orders") { |orders| orders.where(status: "shipped") }

  # Show page customization
  show do
    attributes_table do
      row :id
      row :user do |order|
        link_to order.user.name, admin_user_path(order.user)
      end
      row :total_price do |order|
        number_to_currency(order.total_price)
      end
      row :gst do |order|
        number_to_currency(order.gst)
      end
      row :pst do |order|
        number_to_currency(order.pst)
      end
      row :hst do |order|
        number_to_currency(order.hst)
      end
      row :status
      row :created_at
      row :updated_at
    end

    # Panel for order items
    panel "Order Items" do
      table_for order.order_items do
        column :car do |item|
          link_to "#{item.car.make} #{item.car.model}", admin_car_path(item.car)
        end
        column :quantity
        column :price_at_purchase do |item|
          number_to_currency(item.price_at_purchase)
        end
        column "Total" do |item|
          number_to_currency(item.quantity * item.price_at_purchase)
        end
      end
    end
  end

  # Form customization
  form do |f|
    f.inputs "Order Details" do
      f.input :status, as: :select, collection: ["new", "paid", "shipped"], include_blank: false
      f.input :total_price, input_html: { readonly: true }
      f.input :gst, input_html: { readonly: true }
      f.input :pst, input_html: { readonly: true }
      f.input :hst, input_html: { readonly: true }
    end
    f.actions
  end
end
