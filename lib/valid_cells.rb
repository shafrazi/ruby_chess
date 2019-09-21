module ValidCells
  def valid_moves(current_cell)
    x = current_cell.x
    y = current_cell.y
    board = self.player.board
    valid_locations = []

    # horizontal left
    while x > 0
      x -= 1
      valid_locations << [x, y]
    end

    # horizontal right
    x = current_cell.x
    y = current_cell.y
    while x < 7
      x += 1
      valid_locations << [x, y]
    end

    # vertical up
    x = current_cell.x
    y = current_cell.y
    while y < 7
      y += 1
      valid_locations << [x, y]
    end

    # vertical down
    x = current_cell.x
    y = current_cell.y
    while y > 0
      y -= 1
      valid_locations << [x, y]
    end

    # upward right
    while x < 7 && y < 7
      x += 1
      y += 1
      valid_locations << [x, y]
    end

    # downward right
    x = current_cell.x
    y = current_cell.y
    while x < 7 && y > 0
      x += 1
      y -= 1
      valid_locations << [x, y]
    end

    # upward left
    x = current_cell.x
    y = current_cell.y
    while x > 0 && y < 7
      x -= 1
      y += 1
      valid_locations << [x, y]
    end

    # upward left
    x = current_cell.x
    y = current_cell.y
    while x > 0 && y > 0
      x -= 1
      y -= 1
      valid_locations << [x, y]
    end

    valid_cells = valid_locations.map { |location| board.find_cell_from_location(location) }
  end
end
