require "player"

describe Player do
  let(:game) { double(:game) }
  subject(:player) { described_class.new(:X, game) }

  describe "initialization" do
    it "indicates its piece depending on a value given at initialization" do
      expect(player.piece).to eq :X
    end

    it "receives its parent game at initialization" do
      expect(player.game).to eq game
    end
  end

  describe "#play" do
    it "communicates desired co-ordinates to the game" do
      expect(game).to receive(:play_piece).with(instance_of(described_class), 0, 0)
      player.play(0,0)
    end
  end
end
