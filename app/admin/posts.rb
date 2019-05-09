ActiveAdmin.register Post do
  permit_params :title, :summary, :body, :level, :image

  index do
    selectable_column
    id_column
    column :title
    column :summary
    column :image do |post|
      image_tag post.image.url(:size100x80), class: 'img-show' if post.image?
    end
    column :body do |post|
      post.body.html_safe
    end
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
