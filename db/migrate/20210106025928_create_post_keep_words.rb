class CreatePostKeepWords < ActiveRecord::Migration[6.0]
  def change
    create_table :post_keep_words do |t|

      t.timestamps
    end
  end
end
