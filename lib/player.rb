class Player
  attr_reader :piece, :game

  def initialize(piece, game)
    @piece = piece
    @game = game
  end

  def play(x_coordinate, y_coordinate)
    game.play_piece(self, x_coordinate, y_coordinate)
  end
end
