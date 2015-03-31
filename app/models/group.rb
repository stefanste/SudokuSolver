class Group

  def positions(group_type)
    @positions ||= PositionDatabase.instance.positions.select do |position|
      position.send(group_type) == self
    end
  end

  def unknown_positions
    positions.select {|position| position.unknown? }
  end

  def add(number)
    numbers.delete(0)
    numbers << number
  end

  def [](index)
    @numbers[index]
  end

end
