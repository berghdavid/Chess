require './lib/Piece'

class Knight < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        diff_x = (to[0] - @x).abs
        diff_y = (to[1] - @y).abs

        if((diff_x == 1 && diff_y == 2) || (diff_x == 2 && diff_y == 1))
            if(!board.board[to].nil? && board.board[to].color == @color)
                return false
            else
                return true
            end
        end
        return false
    end

    def all_possible_moves(board)
        possible_moves = []
        moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2],
        [1, -2], [1, 2], [2, -1], [2, 1]]
        for move in moves
            to = [@x + move[0], @y + move[1]]
            inside = within_bounds?(to)
            occupied = board[to].nil? && board[to].color == @color
            if(inside && !occupied)
                possible_moves += [move]
            end
        end
    end

    def get_initials()
        return "N"
    end
end