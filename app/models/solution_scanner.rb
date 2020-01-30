require_relative 'solution_printer'

class SolutionScanner
  MAX_LOOPS_WITHOUT_DISCOVERY = 10
  attr_reader :positions

  def initialize(positions)
    @positions = positions
    @discovery_counter = 0
  end

  def scan!
    while true do
      num_known_positions = known_positions.size

      SolutionPrinter.execute!(@positions) if solved?
      return @positions if solved?

      @positions.each do |position|
        next if position.known?

        scan_position(position)
        scan_group_for_position(position, position.row)
        scan_group_for_position(position, position.column)
        scan_group_for_position(position, position.square)
      end

      @discovery_counter += 1 if num_known_positions == known_positions.size
      if @discovery_counter > MAX_LOOPS_WITHOUT_DISCOVERY
        puts 'Cannot find solution!'
        SolutionPrinter.execute!(@positions)
        return false
      end
    end
  end

  def known_positions
    @positions.select { |position| position.known? }
  end

  def solved?
    known_positions.size == 81
  end

  private

  def scan_group_for_position(position, group)
    position.possible_values.each do |possible_value|
      other_possible_positions_for_value = unknown_positions_in(group) - Array(position)

      if other_possible_positions_for_value.none? {|position| position.could_be?(possible_value) } # Process of elimination
        set_position(position, possible_value)
      end
    end
  end

  def scan_position(position)
    position.scan_row!
    position.scan_column!
    position.scan_square!

    set_position(position, position.possible_values.first) if position.possible_values.size == 1
  end

  def set_position(position, number)
    position.number = number
    @discovery_counter = 0
  end

  def unknown_positions_in(group)
    positions_for(group).select{|position|
      position.unknown?
    }
  end

  def positions_for(group)
    group.position_indexes.map { |index| @positions[index] }
  end
end
