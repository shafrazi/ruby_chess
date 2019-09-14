require_relative "cell"
require_relative "player"

class Board
  attr_reader :row_no, :column_no, :border, :cells

  def initialize
    @border = "---+---+---+---+---+---+---+---+---+---"
    @row_no = 8
    @column_no = 8
    @cells = self.create_cells
  end

  def display_board
    column_names = ["   ", " a ", " b ", " c ", " d ", " e ", " f ", " g ", " h ", "   "]
    row_names = [" 8 ", " 7 ", " 6 ", " 5 ", " 4 ", " 3 ", " 2 ", " 1 "]
    puts "    "
    puts column_names.join("|")
    puts border

    i = row_no - 1
    j = 0
    while i >= 0
      cell_row = cells[i].map { |cell| cell.value }
      cell_row.unshift(row_names[j])
      cell_row.push(row_names[j])
      puts cell_row.join("|")
      puts border
      i -= 1
      j += 1
    end
    puts column_names.join("|")
    puts "    "
  end

  def create_cells
    cell_rows = []
    y = 0
    while y < row_no
      x = 0
      row = []
      while x < column_no
        cell = Cell.new(x, y)
        row << cell
        x += 1
      end
      cell_rows << row
      y += 1
    end
    cell_rows
  end

  def all_cells
    all_cells = []
    self.cells.each do |row|
      row.each do |cell|
        all_cells << cells
      end
    end
    all_cells
  end
end

board = Board.new
board.display_board
