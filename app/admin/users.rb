ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :level, :image, :current_locale

  index do
    selectable_column
    id_column
    column 'Avatar' do |user|
      image_tag user.image.url, width: 50, height: 50
    end
    column :role
    column :level
    column :email
    column :created_at
    column :current_locale
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
      f.input :role, as: :select, collection: %w[guest student operator director admin]
      f.input :level
      f.input :image
      f.input :current_locale, as: :select, collection: %w[en ru]
    end
    f.actions
  end
end
