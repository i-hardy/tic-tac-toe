require "game"

describe Game do
  let(:grid) { double(:grid) }
  let(:moomin) { double(:player) }
  let(:tooticky) { double(:player) }
  let(:player_class) { class_double("Player") }
  subject(:game) { described_class.new(grid, player_class: player_class) }

  before do
    allow(player_class).to receive(:new).with(:X, instance_of(described_class)).and_return(moomin)
    allow(player_class).to receive(:new).with(:O, instance_of(described_class)).and_return(tooticky)
    allow(moomin).to receive(:piece) { :X }
    allow(tooticky).to receive(:piece) { :O }
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

  describe "#play_piece" do
    it "communicates a piece and co-ordinates to the grid" do
      expect(grid).to receive(:place).with(instance_of(Symbol), 0, 0)
      game.play_piece(moomin, 0, 0)
    end

    it "switches the turn" do
      allow(grid).to receive(:place).with(instance_of(Symbol), 0, 0)
      game.play_piece(moomin, 0, 0)
      expect(game.current_turn).to eq tooticky
    end

    it "raises an error if the player given does not match the current turn" do
      expect{ game.play_piece(tooticky, 0, 0) }.to raise_error "Wait your turn!"
    end
  end

  describe "#over?" do
    before do
      allow(grid).to receive(:full_row)
      allow(grid).to receive(:full_column)
      allow(grid).to receive(:full_diagonal)
      allow(grid).to receive(:full?)
    end

    it "returns true if a player has won the game" do
      allow(grid).to receive(:full_row) { :X }
      expect(game).to be_over
    end

    it "returns true if the grid is full even if there is no winner" do
      allow(grid).to receive(:full?) { true }
      expect(game).to be_over
    end

    it "otherwise returns false" do
      expect(game).not_to be_over
    end
  end

  describe "#winner" do
    it "returns the player who has won the game" do
      allow(grid).to receive(:full_row) { :O }
      expect(game.winner).to eq tooticky
    end
  end
end
