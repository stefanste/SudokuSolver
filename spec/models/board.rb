require 'spec_helper'
require 'rails_helper'

describe Board do

  before(:each) do
    PositionDatabase.instance.positions = []
    @board = Board.new(File.open('/home/stefan/sudoku').read)
  end

	it 'should parse the input string into rows and columns correctly' do
    expect(@board.rows[0][1]).to eq(6)
    expect(@board.rows[0][8]).to eq(0)
    expect(@board.rows[0][12]).to be_nil
    expect(@board.rows[3][0]).to eq(8)
    expect(@board.rows[5][3]).to eq(9)
    expect(@board.rows[5][5]).to eq(1)
    expect(@board.rows[5][6]).to eq(0)
    expect(@board.rows[5][8]).to eq(4)
    expect(@board.rows[5][9]).to be_nil
    expect(@board.rows[7][2]).to eq(7)
    expect(@board.rows[8][7]).to eq(7)
    expect(@board.rows[8][8]).to eq(0)

    expect(@board.columns[0][6]).to eq(5)
    expect(@board.columns[0][8]).to eq(0)
    expect(@board.columns[2][7]).to eq(7)
    expect(@board.columns[6][8]).to eq(0)
    expect(@board.columns[6][9]).to be_nil
	end

  it 'should build the square objects correctly' do
    expect(@board.squares[0].numbers).to include(6)
    expect(@board.squares[0].numbers).to include(8)
    expect(@board.squares[0].numbers).to_not include(4)

    expect(@board.squares[1].numbers).to include(3)
    expect(@board.squares[1].numbers).to include(5)
    expect(@board.squares[1].numbers).to include(0)
    expect(@board.squares[1].numbers).to_not include(9)

    expect(@board.squares[4].numbers).to include(7)
    expect(@board.squares[4].numbers).to include(1)
    expect(@board.squares[4].numbers).to include(4)
    expect(@board.squares[4].numbers).to_not include(5)
    expect(@board.squares[4].numbers).to_not include(3)
    expect(@board.squares[4].numbers).to_not include(8)

  end

  it 'should build the position database correctly' do
    expect(positions.size).to eq(81)
    expect(positions[79].number).to eq(7)
    expect(positions[50].number).to eq(1)
    expect(positions[50].row.row_index).to eq(5)
    expect(positions[50].column.column_index).to eq(5)
    # ~~ #
    expect(positions[66].number).to eq(2)
    expect(positions[66].row.row_index).to eq(7)
    expect(positions[66].column.column_index).to eq(3)
  end

  def positions
    PositionDatabase.instance.positions
  end

end
