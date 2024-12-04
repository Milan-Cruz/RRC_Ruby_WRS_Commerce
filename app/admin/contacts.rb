ActiveAdmin.register Contact do
  permit_params :address, :email, :phone, :opening_hours

  form do |f|
    f.inputs "Contact Page Content" do
      f.input :address
      f.input :email
      f.input :phone
      f.input :opening_hours, as: :text
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :address
    column :email
    column :phone
    column :opening_hours
    column :updated_at
    actions
  end

  filter :email
  filter :updated_at
end
