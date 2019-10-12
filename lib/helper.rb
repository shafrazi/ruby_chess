def get_cell(string, game)
  location = game.convert_input(string)
  board = game.board
  board.find_cell_from_location(location)
end

def get_piece(string, game)
  cell = get_cell(string, game)
  board = game.board
  board.find_piece_at_cell(cell)
end
