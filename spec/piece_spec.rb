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
    # it "should return the correct possible cells which are valid" do
    #   player1_knight = board.cells[0][1].piece
    #   cell = board.cells[3][3]
    #   possible_cells = [[2, 1], [4, 1], [5, 2], [1, 2], [1, 4], [2, 5], [4, 5], [5, 4]].map {|arr| board.find_cell_from_location(arr)}.sort_by {|cell| cell.id}
    #   returned_cells = player1_knight.valid_moves(cell).sort_by {|cell| cell.id}
    #   expect(returned_cells).to eql(possible_cells)
    # end

    # it "should return the correct possible cells which are valid" do
    #   player1_knight = board.cells[0][1].piece
    #   cell = board.cells[0][2]
    #   possible_cells = [[4, 1], [0, 1], [3, 2], [1, 2]].map {|arr| board.find_cell_from_location(arr)}
    #   returned_cells = player1_knight.valid_moves(cell)
    #   p cell.id
    #   def check_match(arr1, arr2)
    #     matched = false
    #     arr1.each do |i|
    #       arr2.each do |j|
    #         if i == j
    #           matched = true
    #         end
    #       end
    #     end
    #     matched && arr1.length == arr2.length
    #   end
    #   expect(check_match(possible_cells, returned_cells)).to eql(true)
    # end
  end
end
