class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.timestamps null: false
      t.integer :groupchat_id
      t.string :text
    end
  end
end
