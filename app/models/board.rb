class Board < ApplicationRecord
  has_many :mines, dependent: :destroy

  validates :name, :email, :board_width, :board_height, :num_mines, presence: true
  validates :num_mines, numericality: { less_than_or_equal_to: :max_mines }

  MAX_BOARD_SIZE = 100
  MAX_MINES_PERCENTAGE = 0.4

  def max_mines
    (board_width * board_height * MAX_MINES_PERCENTAGE).floor rescue nil
  end

  def generate_board_state
    # Generate a 2D array of board state objects, with `nil` representing an empty cell
    Array.new(board_height) { Array.new(board_width) }
  end

  def generate_mines
    # Generate `num_mines` unique mine positions and create Mine records for them
    available_positions = (0...board_width * board_height).to_a
    mine_positions = available_positions.sample(num_mines).sort
    mine_positions.each do |position|
      row = position / board_width
      col = position % board_width
      mines.create(row: row, col: col)
    end
  end

  def board_matrix
    matrix = Array.new(board_height) { Array.new(board_width, 0) }
    mines.each do |mine|
      matrix[mine.col][mine.row] = 1
    end
    matrix
  end

  def mine?(row, col)
    mines.exists?(col: col, row: row)
  end
end
