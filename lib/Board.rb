require 'colorize'
require './lib/Piece'

Dir["./lib/Pieces/*.rb"].each {|file| require file }

class Board
    attr_accessor :board, :moves

    def initialize()
        @board = Hash.new
        init_board
        @moves = []
    end

    def init_board()
        # Init pawns
        (1..8).each do |i|
            @board[[i,2]] = Pawn.new("White", [i,2])
            @board[[i,7]] = Pawn.new("Black", [i,7])
        end

        # Init other pieces
        (1..2).each do |i|
            if (i == 1)
                color = "White"
                y = 1
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

    def clear_board()
        @board = Hash.new
    end

    def get_piece(pos)
        return @board[pos]
    end

    def put_piece(piece)
        if(!piece.color.nil? && piece.within_bounds?)
            @board[[piece.x, piece.y]] = piece
        else
            puts "Error: Piece is missing color or not within bounds!"
        end
    end

    def make_move(from, to)
        move = Move.new(@board[from], from, to)
        if(legal_move?(from, to))
            @moves.append(move)

            @board[to] = @board[from]
            @board[from] = nil;
            @board[to].set_pos(to)
            
            return true
        else
            return false
        end
    end

    # Fix errors
    def legal_move?(from, to)
        moving_piece = @board[from]

        if(moving_piece.nil?)
            puts "Illegal move: No piece exists in the moving square."
            return false
        end

        if(@moves.empty?)
            if(moving_piece.color != "White")
                puts "Illegal move: First move should be done by White."
                return false
            end
        elsif(@moves.last.piece.color == moving_piece.color)
            puts "Illegal move: Last move was done by this color."
            return false
        end

        if(moving_piece.possible_move?(self, to))
            return true
        else
            puts "Illegal move: That move is not possible according to chess rules."
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