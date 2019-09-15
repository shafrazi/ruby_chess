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
