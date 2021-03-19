class Piece
    attr_accessor :color, :moves, :x, :y
    def initialize(color = "White", pos)
        @color = color
        @moves = 0
        @x = pos[0]
        @y = pos[1]
    end

    def player_checked?(board)

    end

    def piece_pinned?(board)

    end

    def opp_color()
        if(@color == "White")
            return "Black"
        else
            return "White"
        end
    end

    def within_bounds?(to)
        return (to[0] >= 1 && to[0] <= 8 && to[1] >= 1 && to[1] <= 8)
    end

    def get_initials()
        return "-"
    end
end

class Pawn < Piece
    def possible_move?(board, to)
        diffX = to[0] - @x
        diffY = to[1] - @y
        if(@color == "White")
            right_dir_y = 1
            opp_color = "Black"
            passant_pos_y = 5
        else
            right_dir_y = -1
            opp_color = "White"
            passant_pos_y = 4
        end

        # Doesnt check if the move leaves king in check
        if(!within_bounds?(to))
            return false
        end
        if(diffX == 0 && board[[to[0], to[1]]].nil?)
            if(diffY == right_dir_y)# Move 1
                return true
            elsif(diffY == 2*right_dir_y && @moves == 0 && board[[to[0], to[1] - right_dir_y]].nil?)# Move 2
                return true
            end
        elsif(diffX.abs == 1 && diffY == right_dir_y)
            if(!board[[to[0], to[1]]].nil? && board[[to[0], to[1]]].color == opp_color)# Capture
                return true
            elsif(@y = passant_pos_y && board.moves.last.class == Pawn && board.moves.last.to[0] = to[0])# En passant or capture
                return true
            end
        end
        return false
    end

    def all_possible_moves(board)
        @color == "White" ? right_dir_y = 1 : right_dir_y = -1
        
        moves = [[@x, @y + right_dir_y], [@x, @y + 2*right_dir_y], 
        [@x + 1, @y + right_dir_y], [@x - 1, @y + right_dir_y]]
        
        all_moves = []
        for to in moves
            if(possible_move?(board, to))
                all_moves += [to]
            end
        end
        return all_moves
    end

    def get_initials()
        return "P"
    end
end

class Rook < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to))
            return false
        end

        if(to[0] == @x || to[1] == @y && [@x, @y] != to)
            return empty_path?(board, to)
        end
    end

    def empty_path?(board, to)
        if(@x == to[0])
            @y < to[1] ? dir = 1 : dir = -1 # Direction of movement
            i = @y + dir
            while(i != to[1])
                if(!board[[@x, i]].nil?)
                    return false
                end
                i += dir
            end
            if(board[[@x, i]].nil? && board[[@x, i]].color != opp_color())
                return false
            end
        else
            @x < to[0] ? dir = 1 : dir = -1 # Direction of movement
            i = x + dir
            while(i != to[0])
                if(!board[i, @y].nil?)
                    if(i == to[0] && board[i, @y].color == opp_color())
                        return true
                    else
                        return false
                    end
                end
                i += dir
            end
            if(!board[[i, @y]].nil? && board[[i, @y]].color != opp_color())
                return false
            end
        end
        return false
    end

    def all_possible_moves()

    end

    def get_initials()
        return "R"
    end
end

class Knight < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end

    def get_initials()
        return "N"
    end
end

class Bishop < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end

    def get_initials()
        return "B"
    end
end

class Queen < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end

    def get_initials()
        return "Q"
    end
end

class King < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end

    def get_initials()
        return "K"
    end
end

r = Rook.new("White")