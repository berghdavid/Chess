class Move
    attr_accessor :piece, :from, :to
    def initialize(piece, from, to)
        @piece = piece
        @from = from
        @to = to
    end

    def print_move()
        puts "#{piece.class}: #{$inv_key_mappings[from[0]]}#{from[1]} #{$inv_key_mappings[to[0]]}#{to[1]}"
    end
end