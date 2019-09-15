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

    player1_rooks = player1.pieces.select { |piece| piece.class == Rook }
    player1_bishops = player1.pieces.select { |piece| piece.class == Bishop }
    player1_knights = player1.pieces.select { |piece| piece.class == Knight }
    player1_king = player1.pieces.select { |piece| piece.class == King }
    player1_queen = player1.pieces.select { |piece| piece.class == Queen }
    player1_second_row.each_with_index do |cell, index|
      if index == 0 || index == 7
        player1_rooks.shift.play_piece(cell)
      elsif index == 1 || index == 6
        player1_knights.shift.play_piece(cell)
      elsif index == 2 || index == 5
        player1_bishops.shift.play_piece(cell)
      elsif index == 3
        player1_queen.shift.play_piece(cell)
      elsif index == 4
        player1_king.shift.play_piece(cell)
      end
    end

    player2 = players[1]
    player2_first_row = board.cells[6]
    player2_second_row = board.cells[7]
    player2_pawns = player2.pieces.select { |piece| piece.class == Pawn }
    player2_first_row.each_with_index do |cell, index|
      player2_pawns[index].play_piece(cell)
    end

    player2_rooks = player2.pieces.select { |piece| piece.class == Rook }
    player2_bishops = player2.pieces.select { |piece| piece.class == Bishop }
    player2_knights = player2.pieces.select { |piece| piece.class == Knight }
    player2_king = player2.pieces.select { |piece| piece.class == King }
    player2_queen = player2.pieces.select { |piece| piece.class == Queen }
    player2_second_row.each_with_index do |cell, index|
      if index == 0 || index == 7
        player2_rooks.shift.play_piece(cell)
      elsif index == 1 || index == 6
        player2_knights.shift.play_piece(cell)
      elsif index == 2 || index == 5
        player2_bishops.shift.play_piece(cell)
      elsif index == 3
        player2_queen.shift.play_piece(cell)
      elsif index == 4
        player2_king.shift.play_piece(cell)
      end
    end
  end
end
