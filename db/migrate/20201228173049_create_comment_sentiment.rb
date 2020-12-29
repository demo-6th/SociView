class CreateCommentSentiment < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_sentiment do |t|
      t.integer :comment_sentiment
      t.string :sentiment
      t.integer :comment_id

      t.timestamps
    end
  end
end
