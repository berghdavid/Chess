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
white_pawn1 = Pawn.new("White", [3,3])
white_pawn1.moves = 1 # Disables forward move 2, lets black_pawn3 passant this pawn
white_pawn2 = Pawn.new("White", [5,5])
white_pawn2.moves = 2
black_pawn1 = Pawn.new("Black", [3,4])
black_pawn1.moves = 1
black_pawn2 = Pawn.new("Black", [4,4])
black_pawn2.moves = 2
black_pawn3 = Pawn.new("Black", [2,3])
black_pawn3.moves = 2
board.put_piece(white_pawn1)
board.put_piece(white_pawn2)
board.put_piece(black_pawn1)
board.put_piece(black_pawn2)
board.put_piece(black_pawn3)
board.print_board