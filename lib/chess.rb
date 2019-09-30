require_relative "game"
require_relative "board"
require_relative "cell"
require_relative "piece"
require_relative "player"

# initiate game
# display board
# prompt player 1 to select a piece
# prompt player 1 to select the target cell
# if cell is a valid move and is already occupied by one of their own pieces prompt again for a new cell
# if occupied by opponent's piece capture piece
# if the intended move causes a check notify that the opponent has been checked.
# if the subject piece is king and the intended move will result a check on it, notify that the move cannot be made and prompt for a new cell

game = Game.new
board = game.board
cell = board.cells[0][4]
player1 = game.players[0]
board.display_board
puts cell
# king = board.cells[0][4].piece
# target_cell = board.cells[2][4]
# king.play_piece(target_cell)
# board.display_board
# p board.all_pieces.length
