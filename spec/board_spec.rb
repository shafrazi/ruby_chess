require "./lib/board"

describe Board do
  board = Board.new
  player1 = Player.new("Player 1", board)
  describe "#find_piece_at_cell" do
    it "should return the current piece at target cell" do
      target_cell = board.cells[0][0]
      piece = player1.pieces[9]
      piece.play_piece(target_cell)
      expect(board.find_piece_at_cell(target_cell)).to eql(piece)
    end
  end

  describe "#find_cell_from_location" do
    it "sholud return the corresponding cell when the coordinates are given" do
      target_cell = board.cells[1][3]
      expect(board.find_cell_from_location([3, 1])).to eql(target_cell)
    end
  end
end
