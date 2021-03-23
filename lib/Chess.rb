require 'colorize'
require './lib/Piece'
require './lib/Move'

class Chess
    attr_accessor :board, :moves
    def initialize()
        @board = Hash.new
        init_board
        @moves = []
    end

    def init_board()
        (1..8).each do |i|
            @board[[i,2]] = Pawn.new("White", [i,2])
            @board[[i,7]] = Pawn.new("Black", [i,7])
        end
        (1..2).each do |i|
            if (i == 1)
                color = "White"
                y  = 1
            else
                color = "Black"
                y = 8
            end
            @board[[1,y]] = Rook.new(color, [1,y])
            @board[[2,y]] = Knight.new(color, [2,y])
            @board[[3,y]] = Bishop.new(color, [3,y])
            @board[[4,y]] = Queen.new(color, [4,y])
            @board[[5,y]] = King.new(color, [5,y])
            @board[[6,y]] = Bishop.new(color, [6,y])
            @board[[7,y]] = Knight.new(color, [7,y])
            @board[[8,y]] = Rook.new(color, [8,y])
        end
    end

    def make_move(from, to)
        
    end

    def legal_move?(from, to)
        if(@board[from].nil?)
            return false
        end

        if(@moves.nil? && @board[from].color != "White")
            return false
        elsif(@moves.last.color == @board[from].color)
            return false
        end

        move = Move.new(@board[from], to)
        if(move.piece.possible_move?(@board, to))
            return true
        else
            return false
        end
    end

    def print_board()
        (8).downto(1) do |y|
            puts "\n---------------------------------"
            print "|"
            (1..8).each do |x|
                temp = @board[[x,y]]
                if(temp.nil?)
                    print "   |"
                else
                    print " "
                    if(temp.color == "White")
                        print temp.get_initials.white
                    else
                        print temp.get_initials.blue
                    end
                    print " |"
                end
            end
        end
        puts "\n---------------------------------"
    end
end

c = Chess.new()
c.init_board
c.print_board
puts c.board[[1,1]].possible_move?(c.board, [1,3])
puts c.board[[1,2]].possible_move?(c.board, [1,3])