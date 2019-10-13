require_relative "board"
require_relative "player"
require_relative "cell"
require_relative "piece"

class Game
  attr_reader :players, :board
  attr_accessor :game_complete, :game_won, :check_status, :check_mate

  def initialize
    @board = Board.new
    @players = create_players
    @game_complete = false
    @game_won = false
    @check_status = false
    @check_mate = false
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
    player1.active = true
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

  def active_player
    active_player = nil
    players.each { |player| active_player = player if player.active }
    active_player
  end

  def switch_player
    player1 = players[0]
    player2 = players[1]
    if player1.active
      player2.active = true
      player1.active = false
    else
      player1.active = true
      player2.active = false
    end
  end

  def get_opponent
    opponent = nil
    players.each { |player| opponent = player if !player.active }
    opponent
  end

  def checking(current_cell)
    current_player = active_player
    opponent = get_opponent
    checking_piece = current_cell.piece
    opponent_king = board.all_pieces.find { |piece| piece.player == opponent && piece.class == King }
    checking_piece_moves = checking_piece.valid_moves(current_cell)

    checking_piece_moves.each do |cell|
      if cell.piece == opponent_king
        self.check_status = true
        puts "#{opponent.name} has been checked by #{current_player.name}!"
      end
    end
  end

  def play_game
    while !check_mate
      board.display_board
      array = input_getter
      move_piece(array[0], array[1])
      switch_player
      puts "Game over! #{active_player.name} has encountered a checkmate" if check_mate?
    end
    board.display_board
  end

  def is_checked?
    is_checked = false
    kings = board.all_pieces.select { |piece| piece.class == King }
    kings.each do |king|
      king.check_for_check(king.current_cell)
      if king.check_status
        is_checked = true
        puts "#{king.player.name} has been checked!"
      end
    end
    is_checked
  end

  def check_sequence(player, piece, target_cell)
    valid_move = true
    target_cell_initial_piece = target_cell.piece
    piece_current_cell = piece.current_cell

    king = player.pieces.find { |piece| piece.class == King }

    if piece == king
      valid_move = true
    else
      # piece_current_cell.piece = nil
      target_cell.piece = piece
      target_cell.occupied = true
      king.check_for_check(king.current_cell)

      if king.check_status
        valid_move = false
        puts "Choose another move to evade check!"
      end

      # revert to original state of cells
      target_cell.piece = target_cell_initial_piece
      piece.current_cell = piece_current_cell
      target_cell.occupied = false if !target_cell.piece
    end
    valid_move
  end

  def input_getter
    is_checked?
    puts "#{active_player.name} enter the location of the piece you wish to move:"
    piece = get_piece
    puts "You have chosen #{piece}"
    puts "Enter target location:"
    target_cell = get_cell
    if check_sequence(active_player, piece, target_cell) == false
      input_getter
    else
      [piece, target_cell]
    end
  end

  def move_piece(piece, target_cell)
    if !piece.move_piece(piece.current_cell, target_cell)
      puts "Invalid move. Please select another cell to move piece:"
      target_cell = get_cell
      move_piece(piece, target_cell)
    else
      piece.move_piece(piece.current_cell, target_cell)
    end
  end

  def get_piece
    piece_location = gets.chomp
    piece_location = convert_input(piece_location)
    piece = board.find_piece_at_cell(board.find_cell_from_location(piece_location))
    if piece == nil || piece.player != self.active_player
      puts "Invalid piece selected! Please retry."
      get_piece
    else
      piece
    end
  end

  def get_cell
    target_cell = gets.chomp
    target_cell = board.find_cell_from_location(convert_input(target_cell))
    if target_cell == false
      puts "Invalid cell selected. Please retry."
      get_cell
    else
      target_cell
    end
  end

  def convert_input(string)
    string = string.downcase
    row = ("a".."h").to_a
    column = (1..8).to_a
    x = row.index(string[0])
    y = column.index(string[1].to_i)
    [x, y]
  end

  def check_mate?
    active_player_king = active_player.pieces.find { |piece| piece.class == King }
    active_player_pieces = active_player.pieces
    opponent = get_opponent
    current_cell = active_player_king.current_cell
    check_mate_status = false

    if active_player_king.check_for_check(current_cell)
      check_mate_status = true
      valid_moves = active_player_king.valid_moves(current_cell)
      initial_cell = current_cell # preserve the initial state of the current cell
      current_cell.piece = nil
      current_cell.occupied = false
      valid_moves.each do |cell|
        if active_player_king.check_for_check(cell) == false
          check_mate_status = false
        end
      end

      current_cell = initial_cell # revert back to original state
      current_cell.piece = active_player_king
      current_cell.occupied = true

      active_player_pieces.each do |piece|
        piece.valid_moves(piece.current_cell).each do |cell|
          initial_piece = cell.piece
          initial_cell = cell
          cell.piece = piece
          if active_player_king.check_for_check(current_cell) == false
            check_mate_status = false
          end
          cell = initial_cell
          cell.piece = initial_piece
        end
      end
    end
    check_mate_status
    @check_mate = check_mate_status
  end

  def get_possible_threats(opponent, cell)
    possible_threats = []
    opponent_pieces = opponent.pieces
    opponent_pieces.each do |piece|
      if piece.valid_moves(piece.current_cell).include?(cell)
        possible_threats << piece
      end
    end
    possible_threats
  end

  def possible_evasions?(possible_threats)
    possible_evasions = false
    active_player_moves = active_player.pieces.map { |piece| piece.valid_moves(piece.current_cell) }.flatten
    possible_threat_locations = possible_threats.map { |piece| piece.current_cell }
    active_player_moves.each do |cell|
      if possible_threat_locations.include?(cell)
        possible_evasions = true
      end
    end
    possible_evasions
  end
end
