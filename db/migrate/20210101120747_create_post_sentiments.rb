class CreatePostSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :post_sentiments do |t|
      t.string :sentiment
      t.integer :pid

      t.timestamps
    end
  end
end
