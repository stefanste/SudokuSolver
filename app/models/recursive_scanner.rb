require_relative 'solution_printer'

class RecursiveScanner

  attr_reader :solved, :positions
  alias :solved? :solved

  def initialize(positions, depth = 0)
    @positions = positions
    @depth = depth
  end

  def scan!
    positions_to_scan = sorted_positions
    return positions_to_scan if solved?

    positions_to_scan.each do |position|
      position.possible_values.each do |possible|
        position.number = possible

        begin
          snapshot = deep_clone @positions
          scanner = SolutionScanner.new(snapshot)
          return snapshot if scanner.scan!

          deeper_scan = RecursiveScanner.new(snapshot, @depth += 1).scan!
          return deeper_scan if deeper_scan.present?
        rescue PositionException
          break
        ensure
          position.number = 0 unless @positions.select(&:known?).size == 81
        end
      end
    end
    
    return false
  end

  private

  def sorted_positions
    almost_known = @positions.select {|position| position.almost_known? }

    almost_known.each do |position|
      position.possible_values.sort_by! do |possible|
        position.number = possible

        begin
          snapshot = deep_clone @positions
          scanner = SolutionScanner.new(snapshot)
          scanner.scan!
          if scanner.solved?
            @solved = true
            return scanner.positions
          end
          
          position.search_score = scanner.known_positions.size
        rescue PositionException
          position.search_score = 0
        ensure
          position.number = 0 unless @positions.select(&:known?).size == 81
        end
      end
    end

    almost_known.sort_by! {|position| position.search_score }.reverse
  end

  def deep_clone(object)
    Marshal.load Marshal.dump(object)
  end

end
