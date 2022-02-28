require 'colorize'
require './lib/Piece'
require 'set'

Dir["./lib/Pieces/*.rb"].each {|file| require file }

class Board
    attr_accessor :board, :moves

    def initialize()
        @board = Hash.new
        init_board
    end

    def init_board()
        clear_board

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
        @moves = []
    end

    def get_piece(pos)
        return @board[pos]
    end

    def opp_color(color)
        if(color == "White")
            return "Black"
        else
            return "White"
        end
    end

    def get_next_player()
        if(@moves.length % 2 == 0)
            return "White"
        else
            return "Black"
        end
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
            if(move.piece.class == King && @board[from].legal_castling?(self, to))
                make_castling_moves(to)
            elsif(move.piece == Pawn && (to[1] == 8 || to[1] == 1))
                upgrade_pawn(move)
            else
                @board[to] = @board[from]
                @board[from] = nil;
                @board[to].set_pos(to)
            end
            
            @board[to].moves += 1
            @moves.append(move)
            return true
        else
            return false
        end
    end

    def upgrade_pawn(move)
        while(true)
            puts "What will you promote your pawn to?"
            puts "Queen=q, Rook=r, Bishop=b, Knight=n"
            choice = gets.chomp
            @board[from] = nil
            if(choice == "q")
                @board[to] = Queen.new(move.piece.color, to)
            elsif(choice == "r")
                @board[to] = Queen.new(move.piece.color, to)
            elsif(choice == "b")
                @board[to] = Queen.new(move.piece.color, to)
            elsif(choice == "n")
                @board[to] = Queen.new(move.piece.color, to)
            else
                puts "Not a valid promotion, try again."
            end
        end
    end

    def test_make_move(from, to)
        move = Move.new(@board[from], from, to)
        if(legal_move_no_print?(from, to))
            @board[to] = @board[from]
            @board[from] = nil;
            @board[to].set_pos(to)

            @moves.append(move)
            
            return true
        else
            return false
        end
    end

    def make_castling_moves(to)
        if(to == [3, 1])
            # Left castling
            @board[[5, 1]].set_pos([3, 1])
            @board[[3, 1]] = @board[[5, 1]]
            @board[[5, 1]] = nil
            @board[[1, 1]].set_pos([4, 1])
            @board[[4, 1]] = @board[[1, 1]]
            @board[[1, 1]] = nil
        elsif(to == [7, 1])
            # Right castling
            @board[[5, 1]].set_pos([7, 1])
            @board[[7, 1]] = @board[[5, 1]]
            @board[[5, 1]] = nil
            @board[[8, 1]].set_pos([6, 1])
            @board[[6, 1]] = @board[[8, 1]]
            @board[[8, 1]] = nil
        elsif(to == [3, 8])
            @board[[5, 8]].set_pos([3, 8])
            @board[[3, 8]] = @board[[5, 8]]
            @board[[5, 8]] = nil
            @board[[1, 8]].set_pos([4, 8])
            @board[[4, 8]] = @board[[1, 8]]
            @board[[1, 8]] = nil
        elsif(to == [7, 8])
            @board[[5, 8]].set_pos([7, 8])
            @board[[7, 8]] = @board[[5, 8]]
            @board[[5, 8]] = nil
            @board[[8, 8]].set_pos([6, 8])
            @board[[6, 8]] = @board[[8, 8]]
            @board[[8, 8]] = nil
        else
            puts "Error when castling"
        end
    end

    def print_all_moves
        for move in @moves do
            move.print_move
        end
    end

    def reachable_squares(color)
        reachable_squares = Set[]

        for opp_piece in all_of_color(color)
            reachable_squares.merge(opp_piece.reachable_squares(self))
        end

        return reachable_squares
    end

    def checking_pieces()
        pieces = []
        king = find_king(get_next_player)

        for opp_piece in all_of_color(king.opp_color)
            if(opp_piece.possible_move?(@board, [king.x, king.y]))
                pieces.append(opp_piece)
            end
        end

        return pieces
    end

    def all_of_color(color)
        pieces = []
        (1..8).each do |x|
            (1..8).each do |y|
                if(!@board[[x, y]].nil? && board[[x, y]].color == color)
                    pieces.append(@board[[x, y]])
                end
            end
        end
        return pieces
    end

    def find_king(color)
        (1..8).each do |x|
            (1..8).each do |y|
                to = [x, y]
                if(!board[to].nil? && board[to].class == King && board[to].color == color)
                    return board[to]
                end
            end
        end

        return nil
    end

    def checkmate?()
        color = get_next_player
        if(!in_check?(color))
            return false
        end

        # Init cloned board which can test moves.
        dupe_board = Board.new()
        dupe_board.board = @board.clone
        dupe_board.moves = @moves.clone

        for piece in all_of_color(color) do
            curr_sq = [piece.x, piece.y]
            for move in piece.all_possible_moves(dupe_board) do
                dupe_board.test_make_move(curr_sq, move)
                if(!dupe_board.in_check?(color))
                    # There exists a solution for the checked player
                    puts "Possible move by #{piece.class} [#{piece.x}, #{piece.y}]"
                    puts "[#{move[0]}, #{move[1]}]"

                    puts "Player #{color} is in check!"
                    return false
                end

                # Reset board
                dupe_board.board = @board.clone
                dupe_board.moves = @moves.clone
            end
        end

        puts "Checkmate! #{opp_color(color)} wins!"
        return true
    end

    def in_check?(color)
        king = find_king(color)
        king_sq = [king.x, king.y]
        return reachable_squares(king.opp_color()).include?(king_sq)
    end

    def legal_move_no_print?(from, to)
        moving_piece = @board[from]

        if(moving_piece.nil?)
            return false
        end

        if(@moves.empty?)
            if(moving_piece.color != "White")
                return false
            end
        elsif(@moves.last.piece.color == moving_piece.color)
            return false
        end

        if(moving_piece.possible_move?(self, to))
            return true
        end

        return false
    end

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
        print "    A    B    C    D    E    F    G    H"
        (8).downto(1) do |y|
            puts "\n  -----------------------------------------"
            print "#{y} |"
            (1..8).each do |x|
                temp = @board[[x,y]]
                if(temp.nil?)
                    print "    |"
                else
                    print " "
                    if(temp.color == "White")
                        print temp.get_symbol.white
                    else
                        print temp.get_symbol.blue
                    end
                    print "  |"
                end
            end
            print " #{y}"
        end
        puts "\n  -----------------------------------------"
        puts "    A    B    C    D    E    F    G    H"
    end
end