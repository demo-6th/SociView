class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :cid
      t.integer :pid
      t.text :comment_content
      t.integer :like_count
      t.string :alias
      t.string :url

      t.timestamps
    end
  end
end
