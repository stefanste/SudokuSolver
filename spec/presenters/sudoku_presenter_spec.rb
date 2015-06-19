require 'spec_helper'
require 'rails_helper'

describe SudokuPresenter do

  before do
    @sudoku = double(
                rows: [double(numbers: [1, 2, 3, 5, 7, 0, 0, 0, 0]),
                       double(numbers: [2, 3, 4, 6, 7, 8, 9, 0, 0])
                      ]
              )
    @presenter = SudokuPresenter.new(@sudoku)
  end

  describe '#rows' do
    
    let(:presented_rows) { @presenter.rows }

    it 'should return an array of Fixnum arrays' do
      expect(presented_rows).to be_a(Array)
      expect(presented_rows.first).to be_a(Array)
      expect(presented_rows.first[0]).to be_a(Fixnum)
    end

    it 'should convert any zeros in rows to nils' do
      presented_rows.each do |prow|
        expect(prow).to_not include(0)
        expect(prow).to include(nil)
      end
    end
  end

end
