class CreateGroupchats < ActiveRecord::Migration[8.1]
  def change
    create_table :groupchats do |t|
      t.timestamps null: false
      t.integer :sender_id
      t.integer :reciver_id
    end
  end
end
