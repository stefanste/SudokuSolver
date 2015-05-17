require_relative 'group'

class Square < Group

  attr_accessor :square_index

  def initialize(array, square_index)
    @numbers = array
    @index = square_index
    super
  end

end
