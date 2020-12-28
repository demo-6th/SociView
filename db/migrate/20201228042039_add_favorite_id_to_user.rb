class AddFavoriteIdToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :favorite_id, :integer
    add_index :users, :favorite_id
  end
end
