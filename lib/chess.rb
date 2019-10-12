require_relative "game"
require_relative "board"
require_relative "cell"
require_relative "piece"
require_relative "player"
require_relative "helper"

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
game.play_game
# player1 = game.players[0]
# king = get_piece("e1", game)
# queen2 = get_piece("d8", game)
# pawn = get_piece("e2", game)

# king.play_piece(get_cell("d4", game))
# p king.check_for_check(king.current_cell)

# queen2.play_piece(get_cell("f6", game))
# board.display_board
# p king.check_for_check(king.current_cell)
# p game.check_sequence(player1, pawn, get_cell("e5", game))
# board.display_board
