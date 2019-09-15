require "./lib/player"

describe Player do
  main_board = Board.new
  main_player1 = Player.new("Player 1", main_board)
  describe "#define_color" do
    it "should assign the correct color depending on the player name" do
      board = Board.new
      player = Player.new("Player 1", board)
      expect(player.color).to eql("white")
    end
  end

  describe "#generate_pieces" do
    it "should generate 8 pawn pieces correctly" do
      pawn_pieces = main_player1.pieces.select { |piece| piece.class == Pawn }
      expect(pawn_pieces.length).to eql(8)
      expect(pawn_pieces.all? { |piece| piece.color == "white" })
    end
  end

  describe "#generate_pieces" do
    it "should generate 16 pieces" do
      expect(main_player1.pieces.length).to eql(16)
    end
  end

  describe "#terminate_piece" do
    it "should delete the currentlu occupied piece from existing pieces of player" do
      target_cell = main_board.cells[0][1]
      piece = main_player1.pieces[0]
      piece.play_piece(target_cell)
      main_player1.terminate_piece(target_cell)
      expect(main_player1.pieces.length).to eql(15)
    end
  end
end
