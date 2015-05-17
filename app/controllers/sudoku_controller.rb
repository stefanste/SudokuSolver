class SudokuController < ApplicationController

  include PositionResetter
  
  def index
    @rows = session[:rows].presence || Array.new(9)
    @columns = session[:columns].presence || Array.new(9)
  end

  def new
    session[:rows].clear
    session[:columns].clear
    redirect_to '/'
  end

  def solve
    board = parse_params_into_board

    sudoku = Sudoku.new(board)
    sudoku_presenter = SudokuPresenter.new(sudoku)

    #profile = RubyProf.profile do
      sudoku.solve!
    #end

    #printer = RubyProf::GraphPrinter.new(profile)
    #printer.print(STDOUT, {})

    @rows = sudoku_presenter.rows
    @columns = sudoku_presenter.columns
    render :show
  rescue SudokuException => e
    flash[:error] = e.message
    redirect_to '/'
  ensure
    save_groups(sudoku_presenter)
  end

  private

  def parse_params_into_board
    board = params[:number].values.map{|n| n.present? ? n : '_' }

    9.downto(1).each do |num|
      board.insert(9*num, "\n")
    end

    board.join(' ')
  end

  def save_groups(sudoku_presenter)
    session[:rows] = sudoku_presenter.rows
    session[:columns] = sudoku_presenter.columns
  end

end
