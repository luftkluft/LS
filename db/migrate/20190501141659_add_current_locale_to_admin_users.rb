class AddCurrentLocaleToAdminUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :admin_users, :current_locale, :string, default: 'en', :null => false
  end
end
