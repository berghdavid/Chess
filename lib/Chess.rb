require 'colorize'
require './lib/Board'
require './lib/Piece'
require './lib/Move'

class Chess
    attr_accessor :board, :moves
    def initialize()
        @board = Board.new()
        @moves = []
    end

    def make_move(from, to)
        @board.make_move(from, to)
    end
end

c = Chess.new()
c.board.print_board
puts c.board[[1,1]].possible_move?(c.board, [1,3])
puts c.board[[1,2]].possible_move?(c.board, [1,3])