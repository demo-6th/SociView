class ChangeCidToBeStringInComments < ActiveRecord::Migration[6.0]
  def change
    change_column :comments, :cid, :string
  end
end
