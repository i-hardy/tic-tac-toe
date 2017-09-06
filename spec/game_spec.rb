require "game"

describe Game do
  let(:grid) { double(:grid) }
  let(:moomin) { double(:player) }
  let(:tooticky) { double(:player) }
  let(:player_class) { class_double("Player") }
  subject(:game) { described_class.new(grid, player_class: player_class) }

  before do
    allow(player_class).to receive(:new).with(:X).and_return(moomin)
    allow(player_class).to receive(:new).with(:O).and_return(tooticky)
  end

  describe "initialization" do
    it "takes a grid object at initialization" do
      expect(game.grid).to eq grid
    end

    it "creates two players at initialization and stores them in an array" do
      expect(game.players).to eq [moomin, tooticky]
    end
  end

  describe "#current_turn" do
    it "returns the player whose turn it is, defaulting to the first player" do
      expect(game.current_turn).to eq moomin
    end
  end

  describe "#switch_turns" do
    it "switches the turn" do
      game.switch_turns
      expect(game.current_turn).to eq tooticky
    end
  end
end
