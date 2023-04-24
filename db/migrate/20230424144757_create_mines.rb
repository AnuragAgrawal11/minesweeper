class CreateMines < ActiveRecord::Migration[6.1]
  def change
    create_table :mines do |t|
      t.references :board, null: false, foreign_key: true
      t.integer :row, null: false
      t.integer :col, null: false

      t.timestamps
    end
  end
end
