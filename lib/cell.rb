class Cell
  attr_accessor :x, :y, :player, :occupied, :value, :piece

  def initialize(x, y)
    @x = x
    @y = y
    @player = nil
    @occupied = false
    @value = update_cell_value
    @piece = nil
  end

  def update_cell_value
    if piece
      value = " #{piece.symbol} "
    else
      value = "   "
    end
  end

  def update_cell(piece)
    self.player = piece.player
    self.occupied = true
    self.value = " #{piece.symbol} "
    self.piece = piece
  end

  def vacate_cell
    self.player = nil
    self.occupied = false
    self.value = "   "
    self.piece = nil
  end

  def convert_location(x, y)
    row = ("a".."h").to_a
    column = (1..8).to_a
    x = row[x]
    y = column[y]
    "#{x}#{y}"
  end

  def to_s
    "#{convert_location(x, y)} | x: #{@x}, y: #{@y} | value: #{@value}"
  end
end
