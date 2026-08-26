class Comment < ActiveRecord::Migration[8.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.string :text
      t.timestamps null: false
    end
  end
end
