class CambiarNombresColumnasEnUsuarios < ActiveRecord::Migration[8.1]
  def change
    rename_column :friends, :friend_id, :sent_id
    rename_column :friends, :user_id, :request_id
  end
end
