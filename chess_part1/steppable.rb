module Steppable
  def moves
    r, c = pos
    potential_moves = move_diffs.map do |diff|
      dr, dc = diff
      [r + dr, c + dc] 
    end
    potential_moves.select do |move|
      # valid_moves.include?(move)
      r, c = move
      board[move].color != self.color && r.between?(0, 7) && c.between?(0, 7)
    end
  end

  private
  def move_diffs
    # returns an array of all relative moves that the piece can make with respect to its current position
  end
end