class Game
  attr_reader :grid

  def initialize
    @grid = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end

  def place_x(x_coordinate, y_coordinate)
    raise "That field is claimed" unless field_unclaimed?(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate] = "X"
  end

  def place_o(x_coordinate, y_coordinate)
    raise "That field is claimed" unless field_unclaimed?(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate] = "O"
  end

  private

  def field_unclaimed?(x_coordinate, y_coordinate)
    @grid[x_coordinate][y_coordinate].nil?
  end
end
