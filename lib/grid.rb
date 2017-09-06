class Grid
  attr_reader :game_grid

  def initialize
    @game_grid = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end

  def place(piece, x_coordinate, y_coordinate)
    raise "That field is claimed" if field_claimed?(x_coordinate, y_coordinate)
    @game_grid[x_coordinate][y_coordinate] = piece
  end

  def full_row
    get_full_row ? get_full_row.first : false
  end

  def full_column
    get_full_column ? get_full_column.first : false
  end

  def full_diagonal
    get_full_diagonal ? get_full_diagonal.first : false
  end

  def full?
    game_grid.all? { |row| row.all? { |field| field } }
  end

  private

  def field_claimed?(x_coordinate, y_coordinate)
    game_grid[x_coordinate][y_coordinate]
  end

  def get_full_row(grid: game_grid)
    grid.find { |row| winning_row(row) }
  end

  def get_full_column
    get_full_row(grid: game_grid.transpose)
  end

  def get_full_diagonal
    return diagonal(0.upto(2)) if winning_row(diagonal(0.upto(2)))
    return diagonal(2.downto(0)) if winning_row(diagonal(2.downto(0)))
  end

  def diagonal(range)
    range.each_with_index.map { |row, column| game_grid[row][column] }
  end

  def winning_row(array)
    array ? array.all? { |field| field } && array.uniq.size == 1 : nil
  end
end
