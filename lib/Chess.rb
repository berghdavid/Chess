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
puts c.board.legal_move?([1,1], [1,3])
puts c.board.legal_move?([1,2], [1,3])


###
board = Board.new
board.clear_board

white_knight1 = Knight.new("White", [3, 3])
white_knight2 = Knight.new("White", [5, 4])

black_knight1 = Knight.new("Black", [3, 5])
black_knight2 = Knight.new("Black", [4, 5])

board.put_piece(white_knight1)
board.put_piece(white_knight2)
board.put_piece(black_knight1)
board.put_piece(black_knight2)

board.print_board