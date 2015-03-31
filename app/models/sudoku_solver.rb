require_relative 'board'

puzzle = File.open('/home/stefan/sudoku').read
board = Board.new(puzzle)
board.solve!
