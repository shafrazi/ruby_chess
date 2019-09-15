require_relative "board"
require_relative "player"
require_relative "cell"
require_relative "piece"

class Game
  attr_reader :players, :board
  attr_accessor :game_complete, :game_won

  def initialize
    @board = Board.new
    @players = create_players
    @game_complete = false
    @game_won = false
    initial_setup
  end

  def create_players
    players = []
    player1 = Player.new("Player 1", board)
    player2 = Player.new("Player 2", board)
    players.push(player1, player2)
    players
  end

  def initial_setup
    player1 = players[0]
    player1_first_row = board.cells[1]
    player1_second_row = board.cells[0]
    player1_pawns = player1.pieces.select { |piece| piece.class == Pawn }
    player1_first_row.each_with_index do |cell, index|
      player1_pawns[index].play_piece(cell)
    end

    player2 = players[1]
    player2_first_row = board.cells[6]
    player2_second_row = board.cells[7]
    player2_pawns = player2.pieces.select { |piece| piece.class == Pawn }
    player2_first_row.each_with_index do |cell, index|
      player2_pawns[index].play_piece(cell)
    end
  end
end
