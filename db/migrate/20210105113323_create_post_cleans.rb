class CreatePostCleans < ActiveRecord::Migration[6.0]
  def change
    create_table :post_cleans do |t|

      t.timestamps
    end
  end
end
