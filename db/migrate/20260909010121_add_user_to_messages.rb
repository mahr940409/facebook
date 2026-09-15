class AddUserToMessages < ActiveRecord::Migration[8.1]
  def change
    add_column :messages, :user_id, :integer
  end
end
