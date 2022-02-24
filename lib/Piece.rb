class Piece
    attr_accessor :color, :moves, :x, :y
    def initialize(color = "White", pos)
        @color = color
        @moves = 0
        @x = pos[0]
        @y = pos[1]
    end

    def set_pos(pos)
        @x = pos[0]
        @y = pos[1]
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
        elsif(@y == to[1])
            @x < to[0] ? dir = 1 : dir = -1 # Direction of movement
            i = x + dir
            while(i != to[0])
                if(!board[[i, @y]].nil?)
                    return false
                end
                i += dir
            end
        end

        # Check the last square for eventual capture
        return (board[to].nil? || board[to].color != @color)
    end

    def in_diagonal?(to)
        diffx = to[0] - @x
        diffy = to[1] - @y
        return diffx.abs == diffy.abs
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

        temp = [@x + x_dir, @y + y_dir]
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