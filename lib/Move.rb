class Move
    attr_accessor :piece, :to
    def initialize(piece, to)
        @piece = piece
        @to = to
    end
end