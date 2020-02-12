require_relative "piece"

class Board
  attr_reader :rows
  BACK_ROW = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def initialize(fill = true)
    @sentinel = NullPiece.instance
    @rows = Array.new(8) { Array.new(8, @sentinel) }
    fill_board if fill
  end

  def self.empty_board
    Board.new(false)
  end

  def fill_board
    (0...rows.length).each do |r|
      (0...rows.length).each do |c|
        if r == 1
          @rows[r][c] = Pawn.new(:black, self, [r, c])
        elsif r == 6
          @rows[r][c] = Pawn.new(:white, self, [r, c])
        elsif r == 0
          @rows[r][c] = BACK_ROW[c].new(:black, self, [r, c])
        elsif r == 7
          @rows[r][c] = BACK_ROW[c].new(:white, self, [r, c])
        end
      end
    end
  end

  def in_check?(color)
    # find king position for given color
    king = rows.flatten.find do |piece|
      piece.color == color && piece.class == King
    end
    king_pos = king.pos

    # identify all opponent pieces
    opponents = rows.flatten.select do |piece|
      piece.color != color && piece != sentinel
    end

    opponents.any? do |opponent|
      opponent.moves.include?(king_pos)
    end
  end

  def checkmate?(color)
    pieces = rows.flatten.select do |piece|
      piece.color == color
    end
    pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def dup
    new_board = Board.empty_board
    (0...8).each do |r|
      (0...8).each do |c|
        pos = [r, c]
        if self[pos] == sentinel
          new_board[pos] = sentinel
        else
          color = self[pos].color
          new_board[pos] = self[pos].class.new(color, new_board, pos)
        end
      end
    end
    new_board
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