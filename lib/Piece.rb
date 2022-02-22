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

    def within_bounds?(to = [@x, @y])
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