require_relative "piece"

class Board
  attr_reader :rows
  def initialize
    @rows = Array.new(8) { Array.new(8) }
    @sentinel = nil
    (0...rows.length).each do |r|
      (0...rows.length).each do |c|
        if r == 1 || r == 0
          @rows[r][c] = Piece.new(:black, self, [r, c])
        elsif r == 7 || r == 6
          @rows[r][c] = Piece.new(:white, self, [r, c])
        else
          @rows[r][c] = @sentinel
        end
      end
    end
  end

  def valid_pos?(pos)
    r, c = pos
    raise "Invalid position coordinates" if r >= 8 || r < 0 || c >= 8 || c < 0
  end

  def [](pos)
    valid_pos?(pos)
    r, c = pos
    rows[r][c]
  end

  def []=(pos, piece)
    valid_pos?(pos)
    r, c = pos
    rows[r][c] = piece
  end

  def move_piece(start_pos, end_pos)
    raise "Invalid starting position" if self[start_pos] == sentinel
    raise "Cannot move to ending positon" if self[end_pos] != sentinel && self[end_pos].color == self[start_pos].color

    self[end_pos] = self[start_pos]
    self[end_pos].pos = end_pos
    self[start_pos] = sentinel
  end

  private
  attr_reader :sentinel
end