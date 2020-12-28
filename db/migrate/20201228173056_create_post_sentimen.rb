class CreatePostSentimen < ActiveRecord::Migration[6.0]
  def change
    create_table :post_sentimen do |t|
      t.integer :post_sentimen
      t.string :sentimen
      t.integer :post_id

      t.timestamps
    end
  end
end
