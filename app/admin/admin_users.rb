ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :role, :level, :image
  index do
    selectable_column
    id_column
    column 'Avatar' do |admin_user|
      image_tag admin_user.image.url, width: 100, height: 100
    end
    column :role
    column :level
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
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
