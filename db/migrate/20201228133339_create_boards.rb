class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.integer :board_number
      t.integer :source_id
      t.timestamps
    end
  end
end
