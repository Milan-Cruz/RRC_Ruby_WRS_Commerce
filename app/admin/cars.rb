ActiveAdmin.register Car do
  permit_params :make, :model, :trim, :year, :mileage, :price, :features, category_ids: []

  index do
    selectable_column
    id_column
    column :make
    column :model
    column :trim
    column :year
    column :mileage
    column :price
    actions
  end

  form do |f|
    f.inputs do
      f.input :make
      f.input :model
      f.input :trim
      f.input :year
      f.input :mileage
      f.input :price
      f.input :features
      f.input :categories, as: :check_boxes
    end
    f.actions
  end

  filter :make
  filter :model
  filter :year
  filter :categories
end
