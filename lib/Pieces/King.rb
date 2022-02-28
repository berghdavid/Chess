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

        non_ally_square = (board.board[to].nil? || board.board[to].color == opp_color())

        safe_square = !board.reachable_squares(opp_color()).include?(to)

        return (within_reach && non_ally_square && safe_square)
    end

    def legal_castling?(board, to)
        if(@moves == 0)
            if(@color == "White")
                if(to == [3, 1] && !board.board[[1, 1]].nil? && board.board[[1, 1]].class == Rook && 
                board.board[[1, 1]].moves == 0 && empty_straight_path?(board.board, [2, 1]))
                    # Left castling
                    return true
                elsif(to == [7, 1] && !board.board[[8, 1]].nil? && board.board[[8, 1]].class == Rook && 
                board.board[[8, 1]].moves == 0 && empty_straight_path?(board.board, [7, 1]))
                    # Right castling
                    return true
                end
            elsif(@color == "Black")
                if(to == [3, 8] && !board.board[[1, 8]].nil? && board.board[[1, 8]].class == Rook && 
                board[[1, 1]].moves == 0 && empty_straight_path?(board.board, [2, 8]))
                    return true
                elsif(to == [7, 8] && !board.board[[8, 8]].nil? && board.board[[8, 8]].class == Rook && 
                board.board[[8, 8]].moves == 0 && empty_straight_path?(board.board, [7, 8]))
                    return true
                end
            end
        end
    end

    def make_castling_moves(board, to)
        if(@moves == 0)
            if(@color == "White")
                if(to == [3, 1])
                    # Left castling
                    board.board[[3, 1]] = board.board[[5, 1]]
                    board.board[[5, 1]] = nil
                    board.board[[4, 1]] = board.board[[1, 1]]
                    board.board[[1, 1]] = nil
                elsif(to == [7, 1])
                    # Right castling
                    board.board[[7, 1]] = board.board[[5, 1]]
                    board.board[[5, 1]] = nil
                    board.board[[6, 1]] = board.board[[8, 1]]
                    board.board[[8, 1]] = nil
                end
            elsif(@color == "Black")
                if(to == [3, 8])
                    board.board[[3, 8]] = board.board[[5, 8]]
                    board.board[[5, 8]] = nil
                    board.board[[4, 8]] = board.board[[1, 8]]
                    board.board[[1, 8]] = nil
                elsif(to == [7, 8])
                    board.board[[7, 8]] = board.board[[5, 8]]
                    board.board[[5, 8]] = nil
                    board.board[[6, 8]] = board.board[[8, 8]]
                    board.board[[8, 8]] = nil
                end
            end
        end
    end

    def all_possible_moves(board)
        return reachable_squares(board).select {
            |sq| possible_move?(board, sq)
        }
    end

    def reachable_squares(board)
        reachable_squares = []

        (-1..1).each do |x|
            (-1..1).each do |y|
                to = [@x + x, @y + y]
                if(within_bounds?(to) && to != [@x, @y])
                    reachable_squares.append(to)
                end
            end
        end

        return reachable_squares
    end

    def get_initials()
        return "K"
    end

    def get_symbol()
        return @color == "White" ? "♔" : "♚"
    end
end