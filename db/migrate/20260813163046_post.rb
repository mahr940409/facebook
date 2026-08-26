class Post < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :text
      t.timestamps null: false
    end
  end
end
