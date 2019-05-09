class CreatePictures < ActiveRecord::Migration[5.2]
  def change
    create_table :pictures do |t|
      t.string :image, :string, null: false, default: ''

      t.timestamps
    end
  end
end
