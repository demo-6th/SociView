class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :cid
      t.integer :pid
      t.text :content
      t.integer :like_count
      t.string :alias
      t.string :url
      t.string :author
      t.text :token
      t.text :no_stop
      t.string :sentiment
      t.text :keyword
      t.text :clean

      t.timestamps
    end
  end
end
