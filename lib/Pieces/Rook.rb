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
        all_moves = []
        (1..8).each do |xs|
            to = [xs, @y]
            if(possible_move?(board, to))
                all_moves += [to]
            end
        end
        (1..8).each do |ys|
            to = [@x, ys]
            if(possible_move?(board, to))
                all_moves += [to]
            end
        end
        return all_moves
    end

    def get_initials()
        return "R"
    end
end