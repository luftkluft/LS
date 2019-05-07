class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ''
      t.text :summary, null: false, default: ''
      t.text :body, null: false, default: ''
      t.integer :level, null: false, default: 0

      t.timestamps
    end
  end
end
