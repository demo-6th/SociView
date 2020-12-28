class CreateCommentSentimen < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_sentimen do |t|
      t.integer :comment_sentimen
      t.string :sentimen
      t.integer :comment_id

      t.timestamps
    end
  end
end
