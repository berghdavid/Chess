require 'colorize'
require './lib/Board'
require './lib/Piece'
require './lib/Move'

class Chess
    attr_accessor :board, :moves
    def initialize()
        @board = Board.new()
    end

    def run()
        while(true)
            prompt_move()
        end
    end

    def prompt_move()
        if(@board.moves.length % 2 == 0)
            color = "white"
        else
            color = "black"
        end

        move_done = false
        while(!move_done)
            @board.print_board

            puts "Make your move, #{color}"
            input = gets.chomp

            if(proper_input(input))
                from = [input[0].to_i, input[1].to_i]
                to = [input[2].to_i, input[3].to_i]

                move_done = make_move(from, to)
            end
        end

    end

    def proper_input(input)
        return input.length == 4
        # TODO: Check that all characters are numbers.
    end

    def make_move(from, to)
        return @board.make_move(from, to)
    end
end

###
game = Chess.new()
game.run