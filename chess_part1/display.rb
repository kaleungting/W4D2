require "colorize"
require_relative "cursor.rb"
require_relative "board.rb"

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    @board.rows.each_with_index do |row, r|
      row.each_with_index do |ele, c|
        if @cursor.cursor_pos == [r, c]
          color = (cursor.selected ? :green : :red)
          print ele.to_s.colorize(color) + " "
        else
          print ele.to_s + " "
        end
      end
      puts
    end
    nil
  end
end

b = Board.new
b.move_piece([7, 4], [2, 3])
d = Display.new(b)
while true
  system("clear")
  d.render
  d.cursor.get_input
end