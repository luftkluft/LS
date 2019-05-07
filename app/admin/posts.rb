ActiveAdmin.register Post do
  permit_params :title, :summary, :body, :level

  index do
    selectable_column
    id_column
    column :title
    column :summary
    column :body
    column :level
    actions
  end

  filter :title
  filter :level

  form do |f|
    f.inputs do
      f.input :title
      f.input :summary
      f.input :body
      f.input :level
    end
    f.actions
  end
end
