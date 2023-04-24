class CreateBoards < ActiveRecord::Migration[6.1]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :email
      t.integer :board_width
      t.integer :board_height
      t.integer :num_mines
      t.text :board_state

      t.timestamps
    end
  end
end