ActiveAdmin.register Contact do
  permit_params :address, :email, :phone, :opening_hours

  form do |f|
    f.inputs "Edit Contact Page Details" do
      f.input :address, as: :string
      f.input :email, as: :string
      f.input :phone, as: :string
      f.input :opening_hours, as: :text, input_html: { rows: 5 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :address
      row :email
      row :phone
      row :opening_hours do |contact|
        simple_format(contact.opening_hours)
      end
    end
  end

  index do
    selectable_column
    id_column
    column :address
    column :email
    column :phone
    column :opening_hours do |contact|
      truncate(contact.opening_hours, length: 100)
    end
    actions
  end
end
