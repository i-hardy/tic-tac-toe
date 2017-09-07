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
    get_full_row ? get_full_row.first : nil
  end

  def full_column
    get_full_column ? get_full_column.first : nil
  end

  def full_diagonal
    get_full_diagonal ? get_full_diagonal.first : nil
  end

  def full?
    game_grid.all? { |row| row.all? { |field| field } }
  end

  private

  def field_claimed?(x_coordinate, y_coordinate)
    game_grid[x_coordinate][y_coordinate]
  end

  def get_full_row(grid: game_grid)
    grid.find { |row| row.winning_row? }
  end

  def get_full_column
    get_full_row(grid: game_grid.transpose)
  end

  def get_full_diagonal
    return left_right_diagonal if left_right_diagonal.winning_row?
    return right_left_diagonal if right_left_diagonal.winning_row?
  end

  def left_right_diagonal
    diagonal(0.upto(2))
  end

  def right_left_diagonal
    diagonal(2.downto(0))
  end

  def diagonal(range)
    range.each_with_index.map { |row, column| game_grid[row][column] }
  end
end

class Array
  def winning_row?
    self.all? { |field| field } && self.uniq.size == 1
  end
end
