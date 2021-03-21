class Piece
    attr_accessor :color, :moves, :x, :y
    def initialize(color = "White", pos)
        @color = color
        @moves = 0
        @x = pos[0]
        @y = pos[1]
    end

    def player_checked?(board, color)
        king = find_king
        opposing_pieces = all_of_color(board, king.opp_color)
        for piece in opposing_pieces
            if(piece.possible_move?(board, [king.x, king.y]))
                return false
            end
        end
    end

    def find_king(board, color)
        (1..8).each do |x|
            (1..8).each do |y|
                if(!board[[x, y]].nil? && board[[x, y]].class == King && board[[x, y]].color == color)
                    return board[[x, y]]
                end
            end
        end
        return nil
    end

    def all_of_color(board, color)
        pieces = []
        (1..8).each do |x|
            (1..8).each do |y|
                if(!board[[x, y]].nil? && board[[x, y]].color == color)
                    pieces += board[[x, y]]
                end
            end
        end
        return pieces
    end

    def opp_color()
        if(@color == "White")
            return "Black"
        else
            return "White"
        end
    end

    def within_bounds?(to)
        return (to[0] >= 1 && to[0] <= 8 && to[1] >= 1 && to[1] <= 8)
    end

    def in_straight_path?(to)
        return (@x == to[0] || @y == to[1])
    end

    def empty_straight_path?(board, to)
        if(@x == to[0])
            @y < to[1] ? dir = 1 : dir = -1 # Direction of movement
            i = @y + dir
            while(i != to[1])
                if(!board[[@x, i]].nil?)
                    return false
                end
                i += dir
            end
        else
            @x < to[0] ? dir = 1 : dir = -1 # Direction of movement
            i = x + dir
            while(i != to[0])
                if(!board[i, @y].nil?)
                    return false
                end
                i += dir
            end
        end
        if(!board[[i, @y]].nil? && board[to].color == @color)
            return false
        end
        return true
    end

    def in_diagonal?(to)
        diagonal_squares = []

        x1 = @x
        y1 = @y
        while(x1 != 1 && y1 != 1) #Replace with if x > y else
            x1 -= 1
            y1 -= 1
        end
        while(x1 <= 8 && y1 <= 8)
            diagonal_squares += [[x1, y1]]
            x1 += 1
            y1 += 1
        end

        x2 = @x
        y2 = @y
        while(x2 != 1 && y2 != 8)
            x2 -= 1
            y2 += 1
        end
        while(x2 <= 8 && y2 >= 1)
            diagonal_squares += [[x2, y2]]
            x2 += 1
            y2 -= 1
        end
        diagonal_squares = diagonal_squares.select {
            |sq| sq != [@x, @y] # Removes square [@x, @y]
        }
        return diagonal_squares.include?(@x, @y)
    end

    def empty_diagonal_path?(board, to)
        if(to[0] > @x)
            x_dir = 1
        else
            x_dir = -1
        end
        if(to[1] > @y)
            y_dir = 1
        else
            y_dir = -1
        end
        temp = [@x, @y]
        while(temp != to)
            if(!board[temp].nil?)
                return false
            end
            temp = [temp[0] + x_dir, temp[1] + y_dir]
        end
        if(!board[to].nil? && board[to].color == @color)
            return false
        end
        return true
    end

    def get_initials()
        return "-"
    end
end

class Pawn < Piece
    def possible_move?(board, to)
        diffX = to[0] - @x
        diffY = to[1] - @y
        if(@color == "White")
            right_dir_y = 1
            opp_color = "Black"
            passant_pos_y = 5
        else
            right_dir_y = -1
            opp_color = "White"
            passant_pos_y = 4
        end

        # Doesnt check if the move leaves king in check
        if(!within_bounds?(to))
            return false
        end
        if(diffX == 0 && board[[to[0], to[1]]].nil?)
            if(diffY == right_dir_y)# Move 1
                return true
            elsif(diffY == 2*right_dir_y && @moves == 0 && board[[to[0], to[1] - right_dir_y]].nil?)# Move 2
                return true
            end
        elsif(diffX.abs == 1 && diffY == right_dir_y)
            if(!board[[to[0], to[1]]].nil? && board[[to[0], to[1]]].color == opp_color)# Capture
                return true
            elsif(@y = passant_pos_y && board.moves.last.class == Pawn && board.moves.last.to[0] = to[0])# En passant or capture
                return true
            end
        end
        return false
    end

    def all_possible_moves(board)
        @color == "White" ? right_dir_y = 1 : right_dir_y = -1
        
        moves = [[@x, @y + right_dir_y], [@x, @y + 2*right_dir_y], 
        [@x + 1, @y + right_dir_y], [@x - 1, @y + right_dir_y]]
        
        all_moves = []
        for to in moves
            if(possible_move?(board, to))
                all_moves += [to]
            end
        end
        return all_moves
    end

    def get_initials()
        return "P"
    end
end

class Rook < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] != to)
            return false
        end

        if(in_straight_path?(to))
            return empty_straight_path?(board, to)
        end
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

class Knight < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        diff_x = (to[0] - @x).abs
        diff_y = (to[1] - @y).abs

        if((diff_x == 1 && diff_y == 2) || (diff_x == 2 && diff_y == 1))
            if(!board[[i, @y]].nil? && board[[i, @y]].color == @color)
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

class Bishop < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end    

        if(in_diagonal?(to))
            return empty_diagonal_path?(board, to)
        end
    end

    def all_possible_moves()
        diagonal_squares = []
        x1 = @x
        y1 = @y
        while(x1 != 1 && y1 != 1) #Replace with if x > y else
            x1 -= 1
            y1 -= 1
        end
        while(x1 <= 8 && y1 <= 8)
            diagonal_squares += [[x1, y1]]
            x1 += 1
            y1 += 1
        end

        x2 = @x
        y2 = @y
        while(x2 != 1 && y2 != 8)
            x2 -= 1
            y2 += 1
        end
        while(x2 <= 8 && y2 >= 1)
            diagonal_squares += [[x2, y2]]
            x2 += 1
            y2 -= 1
        end
        possible_moves = diagonal_squares.select {
            |sq| sq != [@x, @y] && possible_move?(board, sq)
        }
        return possible_moves
    end

    def get_initials()
        return "B"
    end
end

class Queen < Piece
    def possible_move?(board, to)
        if(!within_bounds?(to) || [@x, @y] == to)
            return false
        end

        if(in_straight_path?(to))
            return empty_straight_path?(board, to)
        elsif(in_diagonal?(to))
            return empty_diagonal_path?(board, to)
        end
        return false
    end

    def get_initials()
        return "Q"
    end
end

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

r = Rook.new("White")