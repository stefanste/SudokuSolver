require_relative 'group'

class Square < Group

  attr_accessor :numbers, :square_index

  def initialize(array, square_index)
    @numbers = array
    @index = square_index
  end

  def positions
    super(:square)
  end

end
