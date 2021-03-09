class Player
    attr_reader :name, :color
    def initialize(name = "Player 1", color = "White")
        @name = name
        @color = color
        @compAI = compAI
    end

    def read_input
        return gets
    end
end