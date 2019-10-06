require "./lib/piece"

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
      player1_knight = board.cells[0][1].piece
      cell = board.cells[7][0]
      possible_cells = [board.find_cell_from_location([1, 5])]
      expect(player1_knight.valid_moves(cell)).to eql(possible_cells)
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
