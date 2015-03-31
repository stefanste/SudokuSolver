class Position

  attr_accessor :number, :row, :column, :square, :possible_values

  def initialize(number, row, column, square)
    @number = number
    @row = row
    @column = column
    @square = square

    @possible_values = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  def scan_row!
    @possible_values -= @row.numbers
  end

  def scan_column!
    @possible_values -= @column.numbers
  end

  def scan_square!
    @possible_values -= @square.numbers
  end

  def could_be?(number)
    scan_row!
    scan_column!
    scan_square!

    raise "ERROR: Position found with no possible values, unsolvable!" if @possible_values.empty?
    @possible_values.include?(number)
  end

  def unknown?
    @number == 0
  end

  def known?
    @number != 0
  end

end
