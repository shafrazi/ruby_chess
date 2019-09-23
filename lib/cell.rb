class Cell
  attr_accessor :x, :y, :player, :occupied, :value, :piece, :id
  @@cell_id = 0

  def initialize(x, y)
    @x = x
    @y = y
    @player = nil
    @occupied = false
    @value = "   "
    @piece = nil
    @@cell_id += 1
    @id = @@cell_id
  end

  def update_cell(piece)
    self.player = piece.player
    self.occupied = true
    self.value = " #{piece.symbol} "
    self.piece = piece
  end

  def to_s
    "x: #{@x}, y: #{@y}"
  end
end
