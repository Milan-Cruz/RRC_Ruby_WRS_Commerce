ActiveAdmin.register Order do
  permit_params :user_id, :total_price, :status

  index do
    selectable_column
    id_column
    column :user
    column :total_price
    column :status
    column :created_at
    actions
  end

  filter :user
  filter :status
  filter :created_at
end
