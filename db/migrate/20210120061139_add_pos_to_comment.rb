class AddPosToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :pos, :text
  end
end
