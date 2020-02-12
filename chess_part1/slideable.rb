module Slideable
  def horizontal_dirs
    dirs = []
    HORIZONTAL_DIRS.each do |diff|
      dr, dc = diff
      dirs += grow_unblocked_moves_in_dir(dr, dc)
    end
    dirs
  end

  def diagonal_dirs 
    dirs = []
    DIAGONAL_DIRS.each do |diff|
      dr, dc = diff
      dirs += grow_unblocked_moves_in_dir(dr, dc)
    end
    dirs
  end

  # uses move_dirs
  def moves
    if move_dirs == :diagonal
      diagonal_dirs
    elsif move_dirs == :horizontal
      horizontal_dirs
    else
      diagonal_dirs + horizontal_dirs
    end
  end

  private
  HORIZONTAL_DIRS = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  DIAGONAL_DIRS = [[1, 1], [-1, -1], [-1, 1], [1, -1]]

  def move_dirs
    #overwritten by subclass
  end

  def grow_unblocked_moves_in_dir(dr, dc)
    dirs = []
    r, c = pos
    r += dr
    c += dc
    
    until r > 7 || c > 7 || r < 0 || c < 0
      if board[[r, c]].color == self.color
        break
      elsif board[[r, c]].color == :blank
        dirs << [r, c]
      else
        dirs << [r, c]
        break
      end
      r += dr
      c += dc
    end
    dirs
  end
end