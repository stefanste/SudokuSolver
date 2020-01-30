module SolutionPrinter
  def self.execute!(positions)
    (0..8).each do |row|
      puts borderline if row % 3 == 0
      (0..8).each do |row_pos|
        print '| ' if row_pos % 3 == 0
        position_index = 9*row + row_pos
        if positions[position_index].number == 0
          print '_'
        else
          print positions[position_index].number
        end
        print ' '
        print "|\n" if row_pos == 8
      end
      puts borderline if row == 8
    end
    #exit true
  end

  private

  def self.borderline
    '+-------+-------+-------+'
  end
end
