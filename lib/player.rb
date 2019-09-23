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
      pawn = Pawn.new(self)
      pieces << pawn
      i += 1
    end

    i = 0
    while i < 2
      knight = Knight.new(self)
      bishop = Bishop.new(self)
      rook = Rook.new(self)
      pieces.push(knight, bishop, rook)
      i += 1
    end

    king = King.new(self)
    queen = Queen.new(self)
    pieces.push(king, queen)
    pieces
  end

  def terminate_piece(current_cell)
    occupied_piece = board.find_piece_at_cell(current_cell)
    self.pieces.delete_if { |piece| piece == occupied_piece }
  end

  def to_s
    "name: #{@name}"
  end
end
