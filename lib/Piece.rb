class Piece
    attr_accessor :posX, :posY, :color, :moves
    def initialize(posX = 1, posY = 1, color = "White")
        @posX = posX
        @posY = posY
        @color = color
        @moves = 0
    end
end

class Pawn < Piece
    def reachable_square?(square)
        diffY = square[1] - @posY
        diffX = square[0] - @posX
        if @color = "White"
            #Finish
        else
            
        end
        return (@posX == square[0] || @posY == square[1])
    end
end

class Rook < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end
end

class Rook < Piece
    def reachable_square?(square)
        return (@posX == square[0] || @posY == square[1])
    end
end

r = Rook.new(1,1,"Me")
puts r.reachable_square?([2,3])
r.posX = 3
puts r.reachable_square?([3,8])