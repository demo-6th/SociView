class CreatePostSentiments < ActiveRecord::Migration[6.0]
  def change
    create_table :post_sentiments do |t|

      t.timestamps
    end
  end
end
