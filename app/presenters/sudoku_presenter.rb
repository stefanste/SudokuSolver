class SudokuPresenter
  
  def initialize(sudoku)
    @sudoku = sudoku
  end

  def rows
    format(@sudoku.rows)
  end

  def columns
    format(@sudoku.columns)
  end

  private
  
  def format(groups)
    groups.map(&:numbers).map{|numbers_array|
      numbers_array.map{|number|
        number.zero? ? nil : number
      }
    }
  end

end
