require_relative 'group'

class Row < Group

  attr_accessor :numbers, :row_index

  def initialize(row_array, index)
    @numbers = row_array
    @row_index = index
  end

  def positions
    super(:row)
  end

end
