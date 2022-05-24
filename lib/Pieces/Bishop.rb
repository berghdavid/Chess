require './lib/Piece'

class Bishop < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end    

        return (in_diagonal?(to) && empty_diagonal_path?(board.board, to))
    end

    def all_possible_moves(board)
        return reachable_squares(board).select {
            |sq| possible_move?(board, sq)
        }
    end

    def reachable_squares(board)
        reachable_squares = []
        x1 = @x
        y1 = @y
        while(x1 != 1 && y1 != 1) #Replace with if x > y else
            x1 -= 1
            y1 -= 1
        end
        while(x1 <= 8 && y1 <= 8 && reachable_diagonal_path?(board.board, [x1, y1]))
            if([@x, @y] != [x1, y1])
                reachable_squares.append([x1, y1])
            end
            x1 += 1
            y1 += 1
        end

        x2 = @x
        y2 = @y
        while(x2 != 1 && y2 != 8)
            x2 -= 1
            y2 += 1
        end
        while(x2 <= 8 && y2 >= 1 && reachable_diagonal_path?(board.board, [x2, y2]))
            if([@x, @y] != [x2, y2])
                reachable_squares.append([x2, y2])
            end
            x2 += 1
            y2 -= 1
        end

        return reachable_squares
    end

    def get_initials()
        return "B"
    end

    def get_symbol()
        return @color == "White" ? "♗" : "♝"
    end
end