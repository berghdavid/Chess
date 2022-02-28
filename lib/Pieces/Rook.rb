require './lib/Piece'

class Rook < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        if(in_straight_path?(to))
            return empty_straight_path?(board.board, to)
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
        (1..8).each do |xs|
            to = [xs, @y]
            if(within_bounds?(to) && reachable_straight_path?(board.board, to) && to != [@x, @y])
                reachable_squares.append(to)
            end
        end
        (1..8).each do |ys|
            to = [@x, ys]
            if(within_bounds?(to) && reachable_straight_path?(board.board, to) && to != [@x, @y])
                reachable_squares.append(to)
            end
        end
        return reachable_squares
    end

    def get_initials()
        return "R"
    end

    def get_symbol()
        return @color == "White" ? "♖" : "♜"
    end
end