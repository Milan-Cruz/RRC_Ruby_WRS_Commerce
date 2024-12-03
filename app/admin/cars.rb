ActiveAdmin.register Car do
  permit_params :make, :model, :trim, :year, :mileage, :price, :features, :image, category_ids: []

  index do
    selectable_column
    id_column
    column :make
    column :model
    column :trim
    column :year
    column :mileage
    column :price
    column "Image" do |car|
      if car.image.attached?
        image_tag car.image.variant(resize_to_limit: [50, 50])
      else
        "No Image"
      end
    end
    actions
  end

  form do |f|
    f.inputs "Car Details" do
      f.input :make
      f.input :model
      f.input :trim
      f.input :year
      f.input :mileage
      f.input :price
      f.input :features
      f.input :categories, as: :check_boxes
      f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(f.object.image.variant(resize_to_limit: [100, 100])) : "No image uploaded"
    end
    f.actions
  end

  show do
    attributes_table do
      row :make
      row :model
      row :trim
      row :year
      row :mileage
      row :price
      row :features
      row :categories do |car|
        car.categories.map(&:name).join(", ")
      end
      row :image do |car|
        if car.image.attached?
          image_tag car.image.variant(resize_to_limit: [300, 200])
        else
          "No Image"
        end
      end
    end
    active_admin_comments
  end

  filter :make
  filter :model
  filter :year
  filter :categories
end
