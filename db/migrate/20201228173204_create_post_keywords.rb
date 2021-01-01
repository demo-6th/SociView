class CreatePostKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :post_keywords do |t|
      t.text :keyword
      t.integer :pid
      t.timestamps
    end
  end
end
