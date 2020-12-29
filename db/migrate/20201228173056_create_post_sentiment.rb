class CreatePostSentiment < ActiveRecord::Migration[6.0]
  def change
    create_table :post_sentiment do |t|
      t.integer :post_sentiment
      t.string :sentiment
      t.integer :post_id

      t.timestamps
    end
  end
end
