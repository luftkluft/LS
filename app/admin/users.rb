ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :level, :image

  index do
    selectable_column
    id_column
    column 'Avatar' do |user|
      image_tag user.image.url, width: 100, height: 100
    end
    column :role
    column :level
    column :email
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :role
      f.input :level
      f.input :image
    end
    f.actions
  end
end
