require_relative "game"
require_relative "board"
require_relative "cell"
require_relative "piece"
require_relative "player"

game = Game.new
board = game.board
board.display_board
player1 = game.players[0]
player1_pawn = player1.pieces[0]
target_cell = board.cells[6][1]
player1_pawn.play_piece(target_cell)
board.display_board
