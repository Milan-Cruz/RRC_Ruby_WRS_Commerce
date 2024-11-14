ActiveAdmin.register PriceHistory do
  permit_params :car_id, :date_recorded, :price

  index do
    selectable_column
    id_column
    column :car
    column :date_recorded
    column :price
    actions
  end

  filter :car
  filter :date_recorded
end
