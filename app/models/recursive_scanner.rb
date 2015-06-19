require_relative 'solution_printer'

class RecursiveScanner

  def initialize(positions)
    @positions = positions
  end

  def scan
    almost_known = @positions.select {|position| position.almost_known? }
    #almost_known.sort_by! { |position| position.possible_values.size }

    almost_known.each do |position|
      position.possible_values.each do |possible|
        position.number = possible

        begin
          snapshot = deep_clone(@positions)
          scanner = SolutionScanner.new(snapshot)
          return snapshot if scanner.scan

          puts "SCANNING DEEPER!"
          deeper_scan = RecursiveScanner.new(snapshot).scan
          return deeper_scan if deeper_scan.present?
        rescue PositionException
          puts "rescued PositionException"
        ensure
          puts "ENSURANCE!"
          position.number = 0 unless @positions.select(&:known?).size == 81
        end
      end
    end
    
    return false
  end

  private

  def deep_clone(object)
    Marshal.load Marshal.dump(object)
  end

end
