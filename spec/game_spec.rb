require 'game'

describe Game do
  subject(:game) { described_class.new }

  describe "initialization" do
    it "initializes with an empty 3x3 grid" do
      expect(game.grid).to eq [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
    end
  end

  describe "#place_x" do
    it "replaces the given array index with an x" do
      game.place_x(0,0)
      expect(game.grid).to eq [["X",nil,nil],[nil,nil,nil],[nil,nil,nil]]
    end

    it "raises an error if the given index is not currently nil" do
      game.place_o(0,0)
      expect{ game.place_x(0,0) }.to raise_error "That field is claimed"
    end
  end

  describe "#place_o" do
    it "replaces the given array index with an o" do
      game.place_o(1,0)
      expect(game.grid).to eq [[nil,nil,nil],["O",nil,nil],[nil,nil,nil]]
    end

    it "raises an error if the given index is not currently nil" do
      game.place_x(0,0)
      expect{ game.place_o(0,0) }.to raise_error "That field is claimed"
    end
  end
end
