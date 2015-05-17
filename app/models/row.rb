require_relative 'group'

class Row < Group

  attr_accessor :row_index

  def initialize(row_array, index)
    @numbers = row_array
    @row_index = index
    super
  end

end
