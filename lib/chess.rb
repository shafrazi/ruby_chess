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
game.play_game
# puts game.get_piece
# board = game.board
# pawn = board.all_pieces.select { |piece| piece.class == Pawn }[3]
# opponent_queen = board.all_pieces.select { |piece| piece.class == Queen && piece.player.name == "Player 2" }[0]
# cell = board.cells[1][0]
# opponent_queen.play_piece(board.cells[2][1])
# puts pawn.valid_moves(cell)
