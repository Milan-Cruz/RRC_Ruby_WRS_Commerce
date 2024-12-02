ActiveAdmin.register Province do
  permit_params :name, :gst, :pst

  index do
    selectable_column
    id_column
    column :name
    column :gst
    column :pst
    actions
  end

  filter :name
  filter :gst
  filter :pst

  form do |f|
    f.inputs do
      f.input :name
      f.input :gst, as: :number, step: 0.01, label: "GST Rate (%)"
      f.input :pst, as: :number, step: 0.01, label: "PST Rate (%)"
    end
    f.actions
  end
end
