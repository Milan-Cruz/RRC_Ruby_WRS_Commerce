ActiveAdmin.register About do
  permit_params :description

  form do |f|
    f.inputs "About Page Content" do
      f.input :description, as: :text
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :description
    column :updated_at
    actions
  end

  filter :updated_at
end
