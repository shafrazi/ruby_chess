class Cell
  attr_accessor :x, :y, :player, :occupied, :value, :piece

  def initialize(x, y)
    @x = x
    @y = y
    @player = nil
    @occupied = false
    @value = "   "
    @piece = nil
  end

  def update_cell(piece)
    self.player = piece.player
    self.occupied = true
    self.value = " #{piece.symbol} "
    self.piece = piece
  end
end
