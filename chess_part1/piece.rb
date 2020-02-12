require "singleton"
require "colorize"
require_relative "slideable"
require_relative "steppable"

class Piece
  attr_reader :color, :board
  attr_accessor :pos
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s
    if self.color == :white
      symbol.to_s.colorize(:white)
    elsif self.color == :black
      symbol.to_s.colorize(:light_blue)
    else
      symbol.to_s.colorize(:grey)
    end
  end

  def empty?
    color == :blank
  end

  def valid_moves
    # array of where things can move
    moves = []
    (0...8).each do |r|
      (0...8).each do |c|
        pos = [r, c]
        moves << pos if board[pos].color != self.color
      end
    end
    moves
  end

  def symbol
  end

  private
  def move_into_check?(end_pos)
  end

end

class Rook < Piece
  include Slideable

  def symbol
    :r
  end

  protected
  def move_dirs
    :horizontal
  end
end

class Bishop < Piece
  include Slideable

  def symbol
    :b
  end

  protected
  def move_dirs
    :diagonal
  end
end

class Queen < Piece
  include Slideable

  def symbol
    :q
  end

  protected
  def move_dirs
    :all_dirs
  end
end

class Knight < Piece
  include Steppable

  def symbol
    :k
  end

  protected
  def move_diffs
    [
      [-2, 1],
      [-2,-1],
      [2, 1],
      [2, -1],
      [1, 2],
      [1, -2],
      [-1, 2],
      [-1, -2]
    ]
  end
end

class King < Piece
  include Steppable

  def symbol
    :K
  end

  protected
  def move_diffs
    [
      [-1,-1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ]
  end
end

class Pawn < Piece
  def symbol
    :p
  end

  def move_dirs
    forward_steps + side_attacks
  end

  private
  def at_start_row?
    r, c = pos
    (color == :black && r == 1) || (color == :white && r == 6)
  end

  def forward_dir
    return 1 if color == :black
    return -1 if color == :white
  end

  def forward_steps
    r, c = pos
    steps = (at_start_row? ? [[r + forward_dir * 2, c], [r + forward_dir, c]] : [[r + forward_dir, c]])
    steps.select do |dir|
      valid_moves.include?(dir) &&
      board[dir].color == :blank
    end
  end

  def side_attacks
    r, c = pos
    [[r + forward_dir, c + 1], [r + forward_dir, c - 1]].select do |dir|
      valid_moves.include?(dir) && 
      board[dir].color != :blank && 
      board[dir].color != self.color
    end
  end
end

class NullPiece < Piece
  include Singleton
  def initialize
    @color = :blank
  end

  def symbol
    :_
  end

  def moves
    []
  end
end
