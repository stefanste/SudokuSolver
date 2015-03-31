require_relative 'solution_printer'

class SolutionScanner

  def initialize(board)
    @board = board
    @discovery_counter = 0
  end

  def process
    while true do
      num_known_positions = PositionDatabase.instance.known_positions.size
      
      SolutionPrinter.execute! if solved?
      
      positions.each do |position|
        next if position.known?

        scan_position(position)
        scan_group_for_position(position, position.row)
        scan_group_for_position(position, position.column)
        scan_group_for_position(position, position.square)
      end

      new_num_known_positions = PositionDatabase.instance.known_positions.size
      @discovery_counter += 1 if num_known_positions == new_num_known_positions
      if @discovery_counter > 10
        puts 'Cannot find solution!'
        SolutionPrinter.execute! if @discovery_counter > 10
        # Execute recursive strategy!
      end
    end
  end

  private

  def scan_group_for_position(position, group)
    position.possible_values.each do |possible_value|
      other_possible_positions_for_value = group.unknown_positions - Array(position)
      
      if other_possible_positions_for_value.none? {|position| position.could_be?(possible_value) } # Process of elimination
        position.number = possible_value
        position.row.add(possible_value)
        position.column.add(possible_value)
        position.square.add(possible_value)
        @discovery_counter = 0
      end
    end
  end

  def scan_position(position)
    position.scan_row!
    position.scan_column!
    position.scan_square!
  end

  def positions
    PositionDatabase.instance.positions
  end

  def solved?
    PositionDatabase.instance.known_positions.size == 81   
  end

end
