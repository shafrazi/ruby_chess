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
      self.current_cell.vacate_cell if self.current_cell
      target_cell.update_cell(self)
      self.current_cell = target_cell
    else
      if target_cell.player != self.player
        self.current_cell.vacate_cell if self.current_cell
        opponent = target_cell.player
        opponent.terminate_piece(target_cell)
        target_cell.update_cell(self)
        self.current_cell = target_cell
      else
        return false
      end
    end
  end

  def move_piece(current_cell, target_cell)
    if valid_moves(current_cell).include?(target_cell)
      play_piece(target_cell)
    else
      false
    end
  end

  def self_occupy_validator(possible_cells)
    valid_cells = []
    possible_cells.each do |cell|
      if (cell.occupied && cell.player != self.player) || !cell.occupied
        valid_cells << cell
      end
    end
    valid_cells
  end

  def to_s
    "Player: #{player.name} | Class: #{self.class}"
  end
end

class Pawn < Piece
  attr_reader :symbol
  attr_accessor :first_move_completed

  def initialize(player)
    super
    @symbol = generate_symbol
    @first_move_completed = false
  end

  def generate_symbol
    if self.color == "white"
      "♟"
    else
      "♙"
    end
  end

  def play_piece(target_cell)
    if !target_cell.occupied
      self.current_cell.vacate_cell if self.current_cell
      target_cell.update_cell(self)
      self.current_cell = target_cell
    else
      if target_cell.player != self.player
        self.current_cell.vacate_cell if self.current_cell
        opponent = target_cell.player
        opponent.terminate_piece(target_cell)
        target_cell.update_cell(self)
        self.current_cell = target_cell
      else
        return false
      end
    end
  end

  def valid_moves(current_cell)
    x = current_cell.x
    y = current_cell.y
    board = self.player.board
    possible_moves = []
    if first_move_completed
      if self.player.name == "Player 1"
        cell_location = [x, y + 1]
        possible_moves << cell_location if !board.find_cell_from_location(cell_location).occupied
        diagonal_left = [x - 1, y + 1] if x > 0
        capture_validator(diagonal_left, possible_moves) if diagonal_left
        diagonal_right = [x + 1, y + 1] if x < 7
        capture_validator(diagonal_right, possible_moves) if diagonal_right
      else
        cell_location = [x, y - 1]
        possible_moves << cell_location if !board.find_cell_from_location(cell_location).occupied
        diagonal_left = [x - 1, y - 1] if x > 0
        capture_validator(diagonal_left, possible_moves) if diagonal_left
        diagonal_right = [x + 1, y - 1] if x < 7
        capture_validator(diagonal_right, possible_moves) if diagonal_right
      end
    else
      if self.player.name == "Player 1"
        possible_moves << [x, y + 2] if !board.find_cell_from_location([x, y + 2]).occupied
        possible_moves << [x, y + 1] if !board.find_cell_from_location([x, y + 1]).occupied
        diagonal_left = [x - 1, y + 1] if x > 0
        capture_validator(diagonal_left, possible_moves) if diagonal_left
        diagonal_right = [x + 1, y + 1] if x < 7
        capture_validator(diagonal_right, possible_moves) if diagonal_right
      else
        possible_moves << [x, y - 2] if !board.find_cell_from_location([x, y - 2]).occupied
        possible_moves << [x, y - 1] if !board.find_cell_from_location([x, y - 1]).occupied
        diagonal_left = [x - 1, y - 1] if x > 0
        capture_validator(diagonal_left, possible_moves) if diagonal_left
        diagonal_right = [x + 1, y - 1] if x < 7
        capture_validator(diagonal_right, possible_moves) if diagonal_right
      end
    end

    valid_cells = possible_moves.map { |location| board.find_cell_from_location(location) }
    self_occupy_validator(valid_cells)
  end

  def move_piece(current_cell, target_cell)
    if valid_moves(current_cell).include?(target_cell)
      play_piece(target_cell)
      self.first_move_completed = true
    else
      false
    end
  end

  def capture_validator(cell_location, possible_moves_array)
    board = self.player.board
    cell = board.find_cell_from_location(cell_location)
    if cell.occupied && cell.player != self.player
      possible_moves_array << cell_location
    end
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
    if (x + y).even? || (x + y) == 0
      new_array = new_array.select { |arr| (arr[0] + arr[1]).odd? }
    else
      new_array = new_array.select { |arr| (arr[0] + arr[1]).even? }
    end
    valid_cells = new_array.map { |location| board.find_cell_from_location(location) }
    self_occupy_validator(valid_cells)
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
    self_occupy_validator(valid_cells)
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
    self_occupy_validator(valid_cells)
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
    self_occupy_validator(valid_cells)
  end
end

class King < Piece
  attr_reader :symbol
  attr_accessor :check_status

  def initialize(player)
    super
    @symbol = generate_symbol
    @check_status = false
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
    valid_locations << [x + 1, y] if x <= 6
    valid_locations << [x + 1, y + 1] if x <= 6 && y <= 6
    # horizontal left
    valid_locations << [x - 1, y] if x >= 1
    valid_locations << [x - 1, y + 1] if x >= 1 && y <= 6
    # upward
    valid_locations << [x, y + 1] if y <= 6
    valid_locations << [x - 1, y - 1] if x >= 1 && y >= 1
    # downward
    valid_locations << [x, y - 1] if y >= 1
    valid_locations << [x + 1, y - 1] if x <= 6 && y >= 1
    valid_cells = valid_locations.map { |location| board.find_cell_from_location(location) }
    self_occupy_validator(valid_cells)
  end

  def check_for_check(target_cell)
    board = self.player.board
    opponent_pieces = board.all_pieces.select { |piece| piece.player != self.player }
    opponent_pieces.each do |piece|
      opponent_moves = piece.valid_moves(piece.current_cell)
      if opponent_moves.include?(target_cell)
        # puts "You can't move to the specified cell, you will be checked!"
        self.check_status = true
        return true
      end
    end
    self.check_status = false
    return false
  end

  def play_piece(target_cell)
    if !check_for_check(target_cell)
      if !target_cell.occupied
        self.current_cell.vacate_cell if self.current_cell
        target_cell.update_cell(self)
        self.current_cell = target_cell
      else
        if target_cell.player != self.player
          self.current_cell.vacate_cell if self.current_cell
          opponent = target_cell.player
          opponent.terminate_piece(target_cell)
          target_cell.update_cell(self)
          self.current_cell = target_cell
        else
          return false
        end
      end
    else
      return false
    end
  end
end
