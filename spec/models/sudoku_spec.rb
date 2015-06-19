require 'spec_helper'
require 'rails_helper'

describe Sudoku do

  context 'when initialized' do
    before do
      @sudoku =      Sudoku.new(File.open("#{Rails.root}/spec/sudoku").read)
      @hard_sudoku = Sudoku.new(File.open("#{Rails.root}/spec/hard_sudoku").read)
      @evil_sudoku = Sudoku.new(File.open("#{Rails.root}/spec/evil_sudoku").read)
      @mega_sudoku = Sudoku.new(File.open("#{Rails.root}/spec/mega_sudoku").read)
    end

    it 'should parse the input string into rows and columns correctly' do
      expect(@sudoku.rows[0][1]).to eq(6)
      expect(@sudoku.rows[0][8]).to eq(0)
      expect(@sudoku.rows[0][12]).to be_nil
      expect(@sudoku.rows[3][0]).to eq(8)
      expect(@sudoku.rows[5][3]).to eq(9)
      expect(@sudoku.rows[5][5]).to eq(1)
      expect(@sudoku.rows[5][6]).to eq(0)
      expect(@sudoku.rows[5][8]).to eq(4)
      expect(@sudoku.rows[5][9]).to be_nil
      expect(@sudoku.rows[7][2]).to eq(7)
      expect(@sudoku.rows[8][7]).to eq(7)
      expect(@sudoku.rows[8][8]).to eq(0)

      expect(@sudoku.columns[0][6]).to eq(5)
      expect(@sudoku.columns[0][8]).to eq(0)
      expect(@sudoku.columns[2][7]).to eq(7)
      expect(@sudoku.columns[6][8]).to eq(0)
      expect(@sudoku.columns[6][9]).to be_nil
    end

    it 'should build the square objects correctly' do
      expect(@sudoku.squares[0].numbers).to include(6)
      expect(@sudoku.squares[0].numbers).to include(8)
      expect(@sudoku.squares[0].numbers).to_not include(4)

      expect(@sudoku.squares[1].numbers).to include(3)
      expect(@sudoku.squares[1].numbers).to include(5)
      expect(@sudoku.squares[1].numbers).to include(0)
      expect(@sudoku.squares[1].numbers).to_not include(9)

      expect(@sudoku.squares[4].numbers).to include(7)
      expect(@sudoku.squares[4].numbers).to include(1)
      expect(@sudoku.squares[4].numbers).to include(4)
      expect(@sudoku.squares[4].numbers).to_not include(5)
      expect(@sudoku.squares[4].numbers).to_not include(3)
      expect(@sudoku.squares[4].numbers).to_not include(8)

      @sudoku.squares.each do |square|
        expect(square.numbers.size).to eq(9)
      end
    end

    it 'should build the positions correctly' do
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

    context '#solve!' do
      before do
        @sudoku.solve!
      end

      it 'should set the correct numbers for all positions' do
        expect(positions[2].number).to eq(3)
        expect(positions[13].number).to eq(2)
        expect(positions[24].number).to eq(7)
        expect(positions[30].number).to eq(4)
        expect(positions[44].number).to eq(7)
        expect(positions[52].number).to eq(2)
        expect(positions[61].number).to eq(6)
        expect(positions[73].number).to eq(4)
        expect(positions[80].number).to eq(3)
        expect(positions[81]).to be_nil
      end

      it 'should result in 9 unique numbers in each group' do
        [:rows, :columns, :squares].each do |group_type|
          @sudoku.send(group_type).each do |group|
            expect(group.numbers.size).to eq(9)
            expect(group.numbers.uniq.size).to eq(9)
          end
        end
      end
    end

    context '#solve!' do
      it 'should be able to solve the hard sudoku' do
        @hard_sudoku.solve!
        expect(@hard_sudoku.positions.select(&:known?).size).to eq(81)
        [:rows, :columns, :squares].each do |group_type|
          @hard_sudoku.send(group_type).each do |group|
            expect(group.numbers.size).to eq(9)
            expect(group.numbers.uniq.size).to eq(9)
          end
        end
      end

      it 'should be able to solve the evil sudoku' do
        @evil_sudoku.solve!
        expect(@evil_sudoku.positions.select(&:known?).size).to eq(81)
        [:rows, :columns, :squares].each do |group_type|
          @evil_sudoku.send(group_type).each do |group|
            expect(group.numbers.size).to eq(9)
            expect(group.numbers.uniq.size).to eq(9)
          end
        end
      end

      it 'should be able to solve the mega sudoku' do
        @mega_sudoku.solve!
        expect(@mega_sudoku.positions.select(&:known?).size).to eq(81)
        [:rows, :columns, :squares].each do |group_type|
          @mega_sudoku.send(group_type).each do |group|
            expect(group.numbers.size).to eq(9)
            expect(group.numbers.uniq.size).to eq(9)
          end
        end
      end
    end

  end

  def positions
    @sudoku.positions
  end

  def hard_positions
    @hard_sudoku.positions
  end

end
