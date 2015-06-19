class Position

  attr_accessor :number, :row, :column, :square, :possible_values

  ALMOST_KNOWN_SIZE = 3

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

  def number=(number)
    @number = number
    @row.add(number, @column.column_index)
    @column.add(number, @row.row_index)
    @square.add(number, 3 * (@row.row_index % 3) + (@column.column_index % 3))
  end

  def could_be?(number)
    scan_row!
    scan_column!
    scan_square!

    raise PositionException, "ERROR: Position found with no possible values, unsolvable!" if @possible_values.empty?
    @possible_values.include?(number)
  end

  def almost_known?
    unknown? && @possible_values.size <= ALMOST_KNOWN_SIZE
  end

  def unknown?
    @number == 0
  end

  def known?
    @number != 0
  end
end
