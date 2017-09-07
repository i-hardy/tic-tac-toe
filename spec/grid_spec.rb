require "grid"

describe Grid do
  subject(:grid) { described_class.new }

  describe "initialization" do
    it "initializes with an empty 3x3 grid" do
      expect(grid.game_grid).to eq [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    end
  end

  describe "#place" do
    it "replaces the given array index with the given symbol" do
      grid.place(:X, 0,0)
      expect(grid.game_grid).to eq [[:X,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    end

    it "raises an error if the given index is not currently nil" do
      grid.place(:O, 0,0)
      expect{ grid.place(:X, 0,0) }.to raise_error "That field is claimed"
    end
  end

  describe "#full_row" do
    it "returns the element when the grid has a full row of the same truthy element" do
      grid.place(:X, 0,0)
      grid.place(:X, 0,1)
      grid.place(:X, 0,2)
      expect(grid.full_row).to eq :X
    end

    it "returns nil if the grid only has a row with a mixture of elements" do
      grid.place(:X, 0,0)
      grid.place(:O, 0,1)
      grid.place(:X, 0,2)
      expect(grid.full_row).to be nil
    end

    it "returns nil if there is a row of only nil elements" do
      expect(grid.full_row).to be nil
    end
  end

  describe "#full_column" do
    it "returns the element when all rows of the grid have the same element at the same index" do
      grid.place(:X, 0,0)
      grid.place(:X, 1,0)
      grid.place(:X, 2,0)
      expect(grid.full_column).to eq :X
    end

    it "returns nil if the grid only has a column with a mixture of elements" do
      grid.place(:X, 0,0)
      grid.place(:O, 1,0)
      grid.place(:X, 2,0)
      expect(grid.full_row).to be nil
    end

    it "returns nil if there is a column of only nil elements" do
      expect(grid.full_column).to be nil
    end
  end

  describe "#full_diagonal" do
    it "returns the element when there is a full diagonal line of that element descending left to right" do
      grid.place(:X, 0,0)
      grid.place(:X, 1,1)
      grid.place(:X, 2,2)
      expect(grid.full_diagonal).to eq :X
    end

    it "returns the element when there is a full diagonal line of that element descending right to left" do
      grid.place(:X, 0,2)
      grid.place(:X, 1,1)
      grid.place(:X, 2,0)
      expect(grid.full_diagonal).to eq :X
    end

    it "returns nil if there is a diagonal of different elements" do
      grid.place(:X, 0,2)
      grid.place(:O, 1,1)
      grid.place(:X, 2,0)
      expect(grid.full_diagonal).to eq nil
    end

    it "returns nil if the diagonals are nil" do
      expect(grid.full_diagonal).to eq nil
    end
  end

  describe "#full?" do
    it "returns true if the grid is full and there is no winner" do
      allow(grid).to receive(:game_grid) { [[:X, :X, :O],
                                            [:O, :X, :X],
                                            [:X, :O, :O]] }
      expect(grid).to be_full
    end

    it "otherwise returns false" do
      expect(grid).not_to be_full
    end
  end
end

describe Array do
  subject(:array) { described_class.new }

  describe "#winning_row?" do
    it "returns true if a given array contains only identical, truthy elements" do
      3.times { array << :X }
      expect(array).to be_winning_row
    end

    it "otherwise returns false" do
      expect(array).not_to be_winning_row
    end
  end
end
