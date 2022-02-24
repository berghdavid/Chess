require './lib/Piece'

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
        if(diffX == 0 && board.board[[to[0], to[1]]].nil?)
            if(diffY == right_dir_y)# Move 1
                return true
            elsif(diffY == 2*right_dir_y && @moves == 0 && board.board[[to[0], to[1] - right_dir_y]].nil?)# Move 2
                return true
            end
        elsif(diffX.abs == 1 && diffY == right_dir_y)
            if(!board.board[[to[0], to[1]]].nil? && board.board[[to[0], to[1]]].color == opp_color)# Capture
                return true
            elsif(@y == passant_pos_y && !board.moves.empty? && board.moves.last.piece.class == Pawn && board.moves.last.to[0] == to[0])# En passant or capture
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

    def get_symbol()
        return @color == "White" ? "♙" : "♟︎"
    end
end