require "./lib/piece"

describe Piece do
  pawn = Pawn.new("Player 1", "white")
  board = Board.new
  cell = board.cells[0][0]
  describe "#play_piece" do
    it "should change the target cell properties correctly" do
      pawn.play_piece(cell)
      expect(cell.value).to eql(" ♟ ")
      expect(cell.player).to eql("Player 1")
      expect(cell.occupied).to eql(true)
      expect(cell.piece).to eql(pawn)
    end
  end
end
