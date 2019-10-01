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
king1 = player1.pieces.find { |piece| piece.class == King }

board.display_board
target_cell = board.cells[5][4]
king1.play_piece(target_cell)
pawn = board.cells[1][4].piece
puts pawn.valid_moves(pawn.current_cell)
