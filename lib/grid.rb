class Grid
  attr_reader :game_grid

  def initialize
    @game_grid = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end

  def place_x(x_coordinate, y_coordinate)
    raise "That field is claimed" unless field_unclaimed?(x_coordinate, y_coordinate)
    @game_grid[x_coordinate][y_coordinate] = :X
  end

  def place_o(x_coordinate, y_coordinate)
    raise "That field is claimed" unless field_unclaimed?(x_coordinate, y_coordinate)
    @game_grid[x_coordinate][y_coordinate] = :O
  end

  private

  def field_unclaimed?(x_coordinate, y_coordinate)
    @game_grid[x_coordinate][y_coordinate].nil?
  end
end
