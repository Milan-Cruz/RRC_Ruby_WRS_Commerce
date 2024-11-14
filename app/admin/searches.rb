ActiveAdmin.register Search do
  permit_params :user_id, :search_criteria

  index do
    selectable_column
    id_column
    column :user
    column :search_criteria
    column :created_at
    actions
  end

  filter :user
  filter :created_at
end
