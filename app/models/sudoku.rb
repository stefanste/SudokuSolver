require_relative 'row'
require_relative 'column'
require_relative 'square'
require_relative 'group'
require_relative 'position'
require_relative 'position_database'
require_relative 'solution_scanner'

class Sudoku

  attr_accessor :rows, :columns, :squares, :positions

  def initialize(board_input)
    @rows = []
    @columns = []
    @squares = []
    @positions = []

    build_rows(board_input)
    build_columns
    build_squares
    build_positions
  end

  def solve!
    simple_scanner = SolutionScanner.new(@positions)
    simple_scanner.scan!
    return if simple_scanner.solved?

    recursive_scanner = RecursiveScanner.new(@positions)
    @positions = recursive_scanner.scan!
    if @positions.present?
      update_groups_from_positions
    else
      raise SudokuException, "Could not solve!"
    end
  end

  # TODO
  def valid?
    true
  end

  private

  def update_groups_from_positions
    @positions.each_with_index do |position, index|
      @rows[index/9].add(position.number, index % 9)
      @columns[index % 9].add(position.number, index/9)

      square = 3 * (position.row.row_index / 3).floor + (position.column.column_index / 3).floor
      square_index = 3 * (position.row.row_index % 3) + (position.column.column_index % 3)
      @squares[square].add(position.number, square_index)
    end
  end

  def build_positions
    @rows.each_with_index do |row, row_index|
      row.numbers.each_with_index do |number, column_index|
        column = @columns[column_index]
        square = @squares[3 * (row_index / 3).floor + (column_index / 3).floor]

        @positions << Position.new(number, row, column, square)
        @positions.last.set_indexes(9 * row_index + column_index)
      end
    end
  end

  def build_columns
    (0..8).each do |col_index|
      @columns << ::Column.new(rows, col_index)
    end
  end

  def build_squares
    indexes = [(0..2), (3..5), (6..8)]
    
    indexes.each do |range|
      indexes.each do |inner_range|
        numbers = rows[range].map{|row| row[inner_range] }.flatten
        squares << ::Square.new(numbers, squares.size)
      end
    end 
  end

  def build_rows(str)
    fail "Board is not valid." unless self.valid?
    
    line_num = 0
    str.each_line do |line|
      line.gsub! '+', ''
      line.gsub! '-', ''
      line.gsub! '|', ''
      line.gsub! ' ', ' '
      line.gsub! '_', '0'
      line.strip!
      if line.length > 0
        l = line.split
        fail "Line length was #{l.length}" unless l.length == 9
        @rows[line_num] = ::Row.new(l.map {|x| x.to_i}, line_num)
        line_num += 1
      end
    end
  end
end
