class AddCurrentLocaleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_locale, :string, default: 'en', :null => false
  end
end
