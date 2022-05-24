require './lib/Piece'

class Knight < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        diff_x = (to[0] - @x).abs
        diff_y = (to[1] - @y).abs

        if((diff_x == 1 && diff_y == 2) || (diff_x == 2 && diff_y == 1))
            return board.board[to].nil? || board.board[to].color != @color
        end
        return false
    end

    def all_possible_moves(board)
        return reachable_squares(board).select {
            |sq| possible_move?(board, sq)
        }
    end

    def reachable_squares(board)
        covered_squares = []
        moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]]

        for move in moves
            to = [@x + move[0], @y + move[1]]
            if(within_bounds?(to))
                covered_squares.append(to)
            end
        end

        return covered_squares
    end

    def get_initials()
        return "N"
    end

    def get_symbol()
        return @color == "White" ? "♘" : "♞"
    end
end