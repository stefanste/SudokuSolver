require_relative 'row'
require_relative 'column'
require_relative 'square'
require_relative 'group'
require_relative 'position'
require_relative 'position_database'
require_relative 'solution_scanner'

class Board

  attr_accessor :rows, :columns, :squares

  def initialize(square_string)
    @rows = []
    @columns = []
    @squares = []

    init_rows(square_string)
    init_columns
    init_squares
    init_positions
  end

  def solve!
    SolutionScanner.new(self).process
  end

  def valid?
    true
  end

  private

  def init_positions
    @rows.each_with_index do |row, row_index|
      row.numbers.each_with_index do |number, column_index|
        column = @columns[column_index]
        square = @squares[3 * (row_index / 3).floor + (column_index / 3).floor]
        PositionDatabase.instance.positions << Position.new(number, row, column, square)
      end
    end
  end

  def init_columns
    (0..8).each do |col_index|
      @columns << ::Column.new(rows, col_index) 
    end
  end

  def init_squares
    indexes = [(0..2), (3..5), (6..8)]
    
    indexes.each do |range|
      indexes.each do |inner_range|
        numbers = rows[range].map{|row| row[inner_range] }.flatten
        squares << ::Square.new(numbers, squares.size)
      end
    end 
  end

  def init_rows(str)
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

    fail "Board is not valid." unless self.valid?
  end
end
