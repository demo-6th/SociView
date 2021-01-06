class CreatePostKeywords < ActiveRecord::Migration[6.0]
  def change
    create_table :post_keywords do |t|

      t.timestamps
    end
  end
end
