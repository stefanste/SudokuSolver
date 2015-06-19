class Group

  attr_accessor :numbers

  def add(number, index = nil)
    numbers[index] = number
  end

  def [](index)
    @numbers[index]
  end

end
