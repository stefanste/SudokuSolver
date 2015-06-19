require_relative 'group'

class Column < Group

  attr_accessor :column_index

  def initialize(rows, col_index)
    @numbers = rows.map{|row| row.numbers[col_index] }
    @column_index = col_index
  end

end
