class CreateCommentKeepWords < ActiveRecord::Migration[6.0]
  def change
    create_table :comment_keep_words do |t|

      t.timestamps
    end
  end
end
