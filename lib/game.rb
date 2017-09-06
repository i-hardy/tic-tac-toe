require "player"

class Game
  attr_reader :grid, :players, :current_turn

  def initialize(grid, player_class: Player)
    @grid = grid
    @players = [player_class.new(:X), player_class.new(:O)]
    @current_turn = players.first
  end

  def switch_turns
    @current_turn = players.find { |player| player != current_turn }
  end
end
