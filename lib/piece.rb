require_relative "cell"
require_relative "board"
require_relative "game"
require_relative "valid_cells"

class Piece
  attr_accessor :player, :color, :current_cell

  def initialize(player)
    @player = player
    @color = player.color
    @current_cell = nil
  end

  def play_piece(target_cell)
    if !target_cell.occupied
      target_cell.update_cell(self)
      self.current_cell = target_cell
    else
      if target_cell.player != self.player
        opponent = target_cell.player
        opponent.terminate_piece(target_cell)
        target_cell.update_cell(self)
        self.current_cell = target_cell
      else
        return false
      end
    end
  end

  def to_s
    "Player: #{player.name} | Class: #{self.class} | Current cell: #{current_cell}"
  end
end

class Pawn < Piece
  attr_reader :symbol
  attr_accessor :first_move_completed

  def initialize(player)
    super
    @symbol = generate_symbol
    @first_move_completed = true
  end

  def generate_symbol
    if self.color == "white"
      "♟"
    else
      "♙"
    end
  end

  def valid_moves(current_cell)
    x = current_cell.x
    y = current_cell.y
    board = self.player.board
    possible_moves = []
    if first_move_completed
      if self.player.name == "Player 1"
        possible_moves << [x, y + 1]
        possible_moves << [x - 1, y + 1] if x > 0
        possible_moves << [x + 1, y + 1] if x < 7
      else
        possible_moves << [x, y - 1]
        possible_moves << [x - 1, y - 1] if x > 0
        possible_moves << [x + 1, y - 1] if x < 7
      end
    else
      if self.player.name == "Player 1"
        possible_moves << [x, y + 2]
      else
        possible_moves << [x, y - 2]
      end
    end

    possible_cells = possible_moves.map { |location| board.find_cell_from_location(location) }
    possible_cells
  end
end

class Knight < Piece
  attr_reader :symbol

  def initialize(player)
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

  def valid_moves(current_cell)
    x = current_cell.x
    y = current_cell.y
    board = self.player.board
    array = change_cells(x, y)
    new_array = array[0].product(array[1])
    new_array = new_array.select { |arr| (arr[0] + arr[1]).odd? }
    valid_cells = new_array.map { |location| board.find_cell_from_location(location) }
  end

  def change_cells(x, y)
    array_x = []
    x1 = x + 2
    x2 = x - 2
    x3 = x + 1
    x4 = x - 1
    array_x.push(x1) if x1 <= 7
    array_x.push(x2) if x2 >= 0
    array_x.push(x3) if x3 <= 7
    array_x.push(x4) if x4 >= 0

    array_y = []
    y1 = y + 1
    y2 = y - 1
    y3 = y + 2
    y4 = y - 2
    array_y.push(y1) if y1 <= 7
    array_y.push(y2) if y2 >= 0
    array_y.push(y3) if y3 <= 7
    array_y.push(y4) if y4 >= 0
    [array_x, array_y]
  end
end

class Bishop < Piece
  include ValidCells
  attr_reader :symbol

  def initialize(player)
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

  def valid_moves(current_cell)
    board = self.player.board
    valid_cells = diagonal(current_cell, board)
  end
end

class Rook < Piece
  include ValidCells
  attr_reader :symbol

  def initialize(player)
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

  def valid_moves(current_cell)
    board = self.player.board
    valid_cells = horizontal_vertical(current_cell, board)
  end
end

class Queen < Piece
  include ValidCells
  attr_reader :symbol

  def initialize(player)
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

  def valid_moves(current_cell)
    board = self.player.board
    valid_cells = diagonal(current_cell, board) + horizontal_vertical(current_cell, board)
  end
end

class King < Piece
  attr_reader :symbol

  def initialize(player)
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

  def valid_moves(current_cell)
    x = current_cell.x
    y = current_cell.y
    board = self.player.board
    valid_locations = []

    # horizontal right
    valid_locations << [x+1, y] if x <= 6
    valid_locations << [x+1, y+1] if x <= 6 && y <= 6
    # horizontal left
    valid_locations << [x-1, y] if x >= 1
    valid_locations << [x-1, y+1] if x >= 1 && y <= 6
    # upward
    valid_locations << [x, y+1] if y <= 6
    valid_locations << [x-1, y-1] if x >= 1 && y >= 1
    # downward
    valid_locations << [x, y-1] if y >= 1
    valid_locations << [x+1, y-1] if x <= 6 && y >= 1
    valid_cells = valid_locations.map {|location| board.find_cell_from_location(location)}
  end

  def check_for_check(target_cell)
    board = self.player.board
    opponent_pieces = board.all_pieces.select {|piece| piece.player != self.player}
    opponent_pieces.each do |piece|
      opponent_moves = piece.valid_moves(piece.current_cell)
      if opponent_moves.include?(target_cell)
        puts "You can't move to the specified cell, you will be checked!"
        return true
      end
    end
    return false
  end

  def play_piece(target_cell)
    if !check_for_check(target_cell)
      if !target_cell.occupied
        target_cell.update_cell(self)
        self.current_cell = target_cell
      else
        if target_cell.player != self.player
          opponent = target_cell.player
          opponent.terminate_piece(target_cell)
          target_cell.update_cell(self)
          self.current_cell = target_cell
        else
          return false
        end
      end
    end
  end
end



