class AddPosToPost < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :pos, :text
  end
end
