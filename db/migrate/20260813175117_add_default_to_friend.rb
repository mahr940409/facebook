class AddDefaultToFriend < ActiveRecord::Migration[8.1]
  def change
    change_column_default :friends, :status, from: nil, to: "requested"
  end
end
