require "./lib/game"

describe Game do
  game = Game.new
  player1 = game.players[0]
  player2 = game.players[1]
  player1.active = true
  board = game.board
  king1 = player1.pieces.find { |piece| piece.class == King }
  bishop2_1 = player2.pieces.find_all { |piece| piece.class == Bishop }[0]
  bishop2_2 = player2.pieces.find_all { |piece| piece.class == Bishop }[1]
  rook2_1 = player2.pieces.find_all { |piece| piece.class == Rook }[0]
  rook2_2 = player2.pieces.find_all { |piece| piece.class == Rook }[1]
  queen2 = player2.pieces.find { |piece| piece.class == Queen }
  queen1 = player1.pieces.find { |piece| piece.class == Queen }

  describe "#initialize" do
    it "should return the correct number of players" do
      expect(game.players.length).to eql(2)
    end
  end

  describe "#create_players" do
    it "should return the first element as player 1" do
      expect(game.players[0].name).to eql("Player 1")
    end
  end

  describe "#get_possible_threats" do
    it "should return zero possible threats posed by opponent for the given cell location" do
      target_cell = board.cells[2][4]
      king1.play_piece(target_cell)
      possible_threats = []
      expect(game.get_possible_threats(player2, target_cell)).to eql(possible_threats)
    end
  end

  describe "#get_possible_threats" do
    it "should return all possible threats posed by opponent for the given cell location" do
      target_cell = board.cells[2][4]
      king1.play_piece(target_cell)

      possible_threats = []
      expect(game.get_possible_threats(player2, target_cell)).to eql(possible_threats)
    end
  end

  describe "#play_game" do
    it "should return the correct number of total pieces when a piece is moved" do
      piece = board.cells[0][0].piece
      target_cell = board.cells[2][4]
      piece.play_piece(target_cell)
      expect(board.all_pieces.length).to eql(32)
    end
  end

  describe "#possible_evasions?" do
    it "should return true if there is at least 1 evasion method present" do
      bishop2_1.play_piece(board.cells[4][2])
      bishop2_2.play_piece(board.cells[4][6])
      rook2_1.play_piece(board.cells[2][2])
      king_location = king1.current_cell
      possible_threats = game.get_possible_threats(player2, king_location)

      expect(game.possible_evasions?(possible_threats)).to eql(true)
    end

    it "should return false if zero evasion methods are present" do
      queen2.play_piece(board.cells[4][4])
      king_location = king1.current_cell
      board.display_board
      expect(game.check_mate?).to eql(true)
    end
  end
end
