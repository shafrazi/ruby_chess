require_relative "board"
require_relative "cell"
require_relative "piece"

class Player
  attr_reader :name, :board
  attr_accessor :color, :pieces

  def initialize(name, board)
    @name = name
    @color = define_color
    @board = board
    @pieces = generate_pieces
  end

  def define_color
    if self.name == "Player 1"
      self.color = "white"
    else
      self.color = "black"
    end
  end

  def generate_pieces
    pieces = []
    i = 0
    while i < 8
      pawn = Pawn.new(self.name, self.color)
      pieces << pawn
      i += 1
    end

    i = 0
    while i < 2
      knight = Knight.new(self.name, self.color)
      bishop = Bishop.new(self.name, self.color)
      rook = Rook.new(self.name, self.color)
      pieces.push(knight, bishop, rook)
      i += 1
    end

    king = King.new(self.name, self.color)
    queen = Queen.new(self.name, self.color)
    pieces.push(king, queen)
    pieces
  end

  def terminate_piece(current_cell)
    occupied_piece = board.find_piece_at_cell(current_cell)
    self.pieces.delete_if { |piece| piece == occupied_piece }
  end
end
