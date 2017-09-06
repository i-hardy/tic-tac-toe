require "player"

describe Player do
  subject(:player) { described_class.new(:X) }

  describe "initialization" do
    it "indicates its piece depending on a value given at initialization" do
      expect(player.piece).to eq :X
    end
  end
end
