class BoardsController < ApplicationController

  def index
    @boards = Board.order(created_at: :desc).page(params[:page])
  end

  def show
    @board = Board.find(params[:id])
  end

  def new
    @board = Board.new
  end

  def create
    begin
      board = Board.new(board_params)

      if board.valid?
        board.save!
        board.generate_mines
        flash[:success] = "Board created successfully!"
        redirect_to boards_path(board)
      else
        flash.now[:error] = "Error creating board."
        render :new
      end
    rescue => ex
      flash.now[:error] = ex.message
      redirect_to new_board_path
    end

  end

  private

  def board_params
    params.require(:board).permit(:email, :board_width, :board_height, :num_mines, :name)
  end

end
