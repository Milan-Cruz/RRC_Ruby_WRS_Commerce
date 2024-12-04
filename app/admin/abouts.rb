ActiveAdmin.register About do
  permit_params :description

  form do |f|
    f.inputs "Edit About Page Content" do
      f.input :description, as: :text, input_html: { rows: 10 }
    end
    f.actions
  end

  show do
    attributes_table do
      row :description do |about|
        simple_format(about.description)
      end
    end
  end

  index do
    selectable_column
    id_column
    column :description do |about|
      truncate(about.description, length: 100)
    end
    actions
  end
end
