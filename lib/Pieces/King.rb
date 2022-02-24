require './lib/Piece'

class King < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        if(legal_castling?(board, to))
            return true
        end

        diff_x = (to[0] - @x).abs
        diff_y = (to[1] - @y).abs
        within_reach = (diff_x <= 1 && diff_y <= 1)

        if((board[to].nil? || board[to].color == opp_color()) && within_reach)
            return true
        end
        return false
    end

    def legal_castling?(board, to)
        if(@moves == 0)
            if(@color == "White")
                if(to == [3, 1] && !board[[1, 1]].nil? && board[[1, 1]].class == Rook && 
                board[[1, 1]].moves == 0 && empty_straight_path?(board.board, [2, 1]))
                    # Left castling
                    return true
                elsif(to == [7, 1] && !board[[8, 1]].nil? && board[[8, 1]].class == Rook && 
                board[[8, 1]].moves == 0 && empty_straight_path?(board.board, [2, 1]))
                    # Right castling
                    return true
                end
            elsif(@color == "Black")
                if(to == [3, 8] && !board[[1, 8]].nil? && board[[1, 8]].class == Rook && 
                board[[1, 1]].moves == 0 && empty_straight_path?(board.board, [2, 8]))
                    return true
                elsif(to == [7, 8] && !board[[8, 1]].nil? && board[[8, 8]].class == Rook && 
                board[[8, 8]].moves == 0 && empty_straight_path?(board.board, [2, 8]))
                    return true
                end
            end
        end
    end

    def get_initials()
        return "K"
    end

    def get_symbol()
        return @color == "White" ? "♔" : "♚"
    end
end