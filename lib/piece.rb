require_relative "cell"
require_relative "board"
require_relative "game"

class Piece
  attr_accessor :player, :color

  def initialize(player, color)
    @player = player
    @color = color
  end

  def play_piece(target_cell)
    if !target_cell.occupied
      target_cell.update_cell(self)
    else
      if target_cell.player != self.player
        opponent = target_cell.player
        opponent.terminate_piece(target_cell)
        target_cell.update_cell(self)
      else
        return false
      end
    end
  end
end

class Pawn < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♟"
    else
      "♙"
    end
  end
end

class Knight < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♞"
    else
      "♘"
    end
  end
end

class Bishop < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♝"
    else
      "♗"
    end
  end
end

class Rook < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♜"
    else
      "♖"
    end
  end
end

class Queen < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♛"
    else
      "♕"
    end
  end
end

class King < Piece
  attr_reader :symbol

  def initialize(player, color)
    super
    @symbol = generate_symbol
  end

  def generate_symbol
    if self.color == "white"
      "♚"
    else
      "♔"
    end
  end
end
