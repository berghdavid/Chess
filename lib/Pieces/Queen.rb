require './lib/Piece'

class Queen < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        if(in_straight_path?(to))
            return empty_straight_path?(board.board, to)
        elsif(in_diagonal?(to))
            return empty_diagonal_path?(board.board, to)
        end
        return false
    end

    def get_initials()
        return "Q"
    end
end