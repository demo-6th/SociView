class CreatePostTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :post_tokens do |t|

      t.timestamps
    end
  end
end
