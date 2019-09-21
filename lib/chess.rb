require_relative "game"
require_relative "board"
require_relative "cell"
require_relative "piece"
require_relative "player"

game = Game.new
board = game.board
cell = board.cells[0][7]
player1 = game.players[0]
board.display_board
player1_rook = King.new(player1)
p player1_rook.valid_moves(cell)
