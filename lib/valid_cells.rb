module ValidCells
  def diagonal(current_cell, board)
    valid_cells = []
    x = current_cell.x
    y = current_cell.y
    if x <= 6 && y <= 6
      x += 1
      y += 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x < 7 && y < 7
      previous_cell = board.find_cell_from_location([x, y])
      x += 1
      y += 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # downward right
    x = current_cell.x
    y = current_cell.y
    if x <= 6 && y >= 1
      x += 1
      y -= 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x < 7 && y > 0
      previous_cell = board.find_cell_from_location([x, y])
      x += 1
      y -= 1
      cell = board.find_cell_from_location([x, y])
      if !previous_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # upward left
    x = current_cell.x
    y = current_cell.y

    if x >= 1 && y <= 6
      x -= 1
      y += 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x > 0 && y < 7
      previous_cell = board.find_cell_from_location([x, y])
      x -= 1
      y += 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # upward left
    x = current_cell.x
    y = current_cell.y
    if x >= 1 && y >= 1
      x -= 1
      y -= 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x > 0 && y > 0
      previous_cell = board.find_cell_from_location([x, y])
      x -= 1
      y -= 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    valid_cells
  end

  def horizontal_vertical(current_cell, board)
    valid_cells = []
    x = current_cell.x
    y = current_cell.y

    # horizontal left
    if x >= 1
      x -= 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x > 0
      previous_cell = board.find_cell_from_location([x, y])
      x -= 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # horizontal right
    x = current_cell.x
    y = current_cell.y

    if x <= 6
      x += 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while x < 7
      previous_cell = board.find_cell_from_location([x, y])
      x += 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # vertical up
    x = current_cell.x
    y = current_cell.y

    if y <= 6
      y += 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while y < 7
      previous_cell = board.find_cell_from_location([x, y])
      y += 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    # vertical down
    x = current_cell.x
    y = current_cell.y

    if y >= 1
      y -= 1
      first_cell = board.find_cell_from_location([x, y])
      valid_cells << first_cell
    end

    while y > 0
      previous_cell = board.find_cell_from_location([x, y])
      y -= 1
      cell = board.find_cell_from_location([x, y])
      if !first_cell.occupied && !previous_cell.occupied
        valid_cells << cell
      else
        break
      end
    end

    valid_cells
  end
end
