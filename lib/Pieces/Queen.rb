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

    def all_possible_moves(board)
        return reachable_squares(board).select {
            |sq| possible_move?(board, sq)
        }
    end

    def reachable_squares(board)
        reachable_squares = []

        (1..8).each do |x|
            (1..8).each do |y|
                to = [x, y]
                if(in_straight_path?(to) && reachable_straight_path?(board.board, to) && [@x, @y] != to)
                    reachable_squares.append(to)
                elsif(in_diagonal?(to) && reachable_diagonal_path?(board.board, to) && [@x, @y] != to)
                    reachable_squares.append(to) 
                end
            end
        end

        return reachable_squares
    end

    def get_initials()
        return "Q"
    end

    def get_symbol()
        return @color == "White" ? "♕" : "♛"
    end
end