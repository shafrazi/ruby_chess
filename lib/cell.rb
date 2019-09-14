class Cell
  attr_accessor :x, :y, :player, :occupied, :value, :piece

  def initialize(x, y)
    @x = x
    @y = y
    @player = false
    @occupied = false
    @value = "   "
    @piece = nil
  end
end
