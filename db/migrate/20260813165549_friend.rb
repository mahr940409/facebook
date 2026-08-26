class Friend < ActiveRecord::Migration[8.1]
  def change
    create_table :friends do |t|
      t.integer :user_id
      t.integer :friend_id
      t.string :status
      t.timestamps null: false
    end
  end
end
