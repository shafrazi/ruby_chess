require "./lib/piece"

def get_cell(string, game)
  location = game.convert_input(string)
  board = game.board
  board.find_cell_from_location(location)
end

def get_piece(string, game)
  cell = get_cell(string, game)
  board = game.board
  board.find_piece_at_cell(cell)
end

describe Piece do
  board = Board.new
  player1 = Player.new("Player 1", board)
  pawn = Pawn.new(player1)
  cell = board.cells[0][0]
  describe "#play_piece" do
    it "should change the target cell properties correctly" do
      pawn.play_piece(cell)
      expect(cell.value).to eql(" ♟ ")
      expect(cell.player).to eql(player1)
      expect(cell.occupied).to eql(true)
      expect(cell.piece).to eql(pawn)
    end
  end
end

describe Knight do
  game = Game.new
  board = game.board
  player1 = game.players[0]
  player2 = game.players[1]
  describe "#valid_moves" do
    it "should return the correct possible cells which are valid" do
      player1_knight = board.cells[0][1].piece
      cell = board.cells[0][0]
      possible_cells = [board.find_cell_from_location([1, 2])]
      expect(player1_knight.valid_moves(cell)).to eql(possible_cells)
    end
  end

  describe "#valid_moves" do
    it "should return the correct possible cells which are valid on player 2 side" do
      player2_knight = board.cells[7][6].piece
      possible_cells = [board.find_cell_from_location([7, 5]), board.find_cell_from_location([5, 5])]
      expect(player2_knight.valid_moves(player2_knight.current_cell)).to eql(possible_cells)
    end
  end
  
  describe '#check_for_check' do
    game = Game.new
    player1 = game.players[0]
    player2 = game.players[1]
    board = game.board
    king1 = player1.pieces.find { |piece| piece.class == King }
    rook2_1 = player2.pieces.find_all { |piece| piece.class == Rook }[0]

    it 'should return true if king is being checked' do
      king1.play_piece(board.cells[2][5])
      rook2_1.play_piece(board.cells[2][2])
      expect(king1.check_for_check(king1.current_cell)).to eql(true)
    end
  end
end

describe Queen do
  game = Game.new
  board = game.board
  player1 = game.players[0]
  player2 = game.players[1]
  queen2 = player2.pieces.find {|piece| piece.class == Queen}

  describe '#valid_moves' do
    it 'should return zero valid moves on start of game' do
      expect(queen2.valid_moves(queen2.current_cell)).to eql([])
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      queen2.play_piece(get_cell("a6", game))
      expect(queen2.valid_moves(queen2.current_cell).length).to eql(15)
    end
  end
end

describe King do
  game = Game.new
  board = game.board
  player1 = game.players[0]
  player2 = game.players[1]
  king2 = player2.pieces.find {|piece| piece.class == King}

  describe '#valid_moves' do
    it 'should return zero valid moves on start of game' do
      expect(king2.valid_moves(king2.current_cell)).to eql([])
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      king2.play_piece(get_cell("a6", game))
      expect(king2.valid_moves(king2.current_cell).length).to eql(3)
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      king2.play_piece(get_cell("d5", game))
      expect(king2.valid_moves(king2.current_cell).length).to eql(8)
    end
  end
end

describe Bishop do
  game = Game.new
  board = game.board
  player1 = game.players[0]
  player2 = game.players[1]
  bishop2 = player2.pieces.find {|piece| piece.class == Bishop}

  describe '#valid_moves' do
    it 'should return zero valid moves on start of game' do
      expect(bishop2.valid_moves(bishop2.current_cell)).to eql([])
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      bishop2.play_piece(get_cell("a6", game))
      expect(bishop2.valid_moves(bishop2.current_cell).length).to eql(4)
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      bishop2.play_piece(get_cell("d5", game))
      expect(bishop2.valid_moves(bishop2.current_cell).length).to eql(8)
    end
  end
end

describe Pawn do
  game = Game.new
  board = game.board
  player1 = game.players[0]
  player2 = game.players[1]
  pawn2 = get_piece("e7", game)
  puts pawn2
  describe '#valid_moves' do
    it 'should return valid moves on start of game' do
      possible_cells = [get_cell("e6", game), get_cell("e5", game)].sort
      expect(pawn2.valid_moves(pawn2.current_cell).sort).to eql(possible_cells)
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      pawn2.move_piece(pawn2.current_cell, get_cell("e5", game))
      expect(pawn2.valid_moves(pawn2.current_cell).length).to eql(1)
    end

    it 'should return the valid number of moves when given a from a specifc location' do
      pawn2.play_piece(get_cell("e3", game))
      expect(pawn2.valid_moves(pawn2.current_cell).length).to eql(2)
    end
  end
end

