require_relative "slideable"
require_relative "steppable"

class Piece
  attr_reader :color, :board
  attr_accessor :pos
  def initialize(color, board, pos)
    @color, @board, @pos = color, board, pos
  end

  def to_s

  end

  def empty?

  end

  def valid_moves
  
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

  end
end

class Bishop < Piece
  include Slideable

  def symbol
    :b
  end

  protected
  def move_dirs
    
  end
end

class Queen < Piece
  include Slideable

  def symbol
    :q
  end

  protected
  def move_dirs
    
  end
end

class Knight < Piece
  include Steppable

  def symbol
    :k
  end

  protected
  def move_dirs
    
  end
end

class King < Piece
  include Steppable

  def symbol
    :K
  end

  protected
  def move_dirs
    
  end
end

class Pawn < Piece
  def symbol
    :p
  end

  def move_dirs
    
  end

  private
  def at_start_row?

  end

  def forward_dir

  end

  def forward_steps

  end

  def side_attacks

  end
end

class NullPiece < Piece
  include Singleton
  def initialize

  end

  def symbol
    :_
  end

  def moves
    []
  end
end
