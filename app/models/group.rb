class Group

  attr_accessor :numbers, :position_indexes

  def initialize(group_array, index)
    @position_indexes = []
  end

  def add(number, index = nil)
    numbers[index] = number
  end

  def [](index)
    @numbers[index]
  end

end
