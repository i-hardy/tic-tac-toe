require "player"

class Game
  attr_reader :grid, :players, :current_turn

  def initialize(grid, player_class: Player)
    @grid = grid
    @players = [player_class.new(:X, self), player_class.new(:O, self)]
    @current_turn = players.first
  end

  def play_piece(player, x_coordinate, y_coordinate)
    raise "Wait your turn!" unless player == current_turn
    grid.place(player.piece, x_coordinate, y_coordinate)
    switch_turns
  end

  def over?
    !!check_for_winner || grid.full?
  end

  def winner
    players.find { |player| player.piece == check_for_winner }
  end

  private

  def check_for_winner
    grid.full_row || grid.full_column || grid.full_diagonal
  end

  def switch_turns
    @current_turn = players.find { |player| player != current_turn }
  end
end
