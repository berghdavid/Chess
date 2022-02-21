require './lib/Piece'

class King < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        diff_x = (to[0] - @x).abs
        diff_y = (to[1] - @y).abs
        within_reach = (diff_x <= 1 && diff_y <= 1)

        if(legal_rockade?(board, to))
            return true
        end

        if((board[to].nil? || board[to].color == opp_color()) && within_reach)
            return true
        end
        return false
    end

    def legal_rockade?(board, to)
        if(@moves == 0)
            if(@color == "White")
                if(to == [3, 1] && !board[[1, 1]].nil? && board[[1, 1]].class == Rook && 
                board[[1, 1]].moves == 0 && empty_straight_path?(board, [2, 1]))
                    return true
                elsif(to == [7, 1] && !board[[8, 1]].nil? && board[[8, 1]].class == Rook && 
                board[[8, 1]].moves == 0 && empty_straight_path?(board, [2, 1]))
                    return true
                end
            elsif(@color == "Black")
                if(to == [3, 1] && !board[[1, 1]].nil? && board[[1, 1]].class == Rook && 
                board[[1, 1]].moves == 0 && empty_straight_path?(board, [2, 1]))
                    return true
                elsif(to == [7, 1] && !board[[8, 1]].nil? && board[[8, 1]].class == Rook && 
                board[[8, 1]].moves == 0 && empty_straight_path?(board, [2, 1]))
                    return true
                end
            end
        end
    end

    def get_initials()
        return "K"
    end
end