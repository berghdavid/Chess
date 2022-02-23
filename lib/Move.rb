class Move
    attr_accessor :piece, :from, :to
    def initialize(piece, from, to)
        @piece = piece
        @from = from
        @to = to
    end
end