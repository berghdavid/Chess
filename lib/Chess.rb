require 'colorize'
require './lib/Board'
require './lib/Piece'
require './lib/Move'

$key_mappings = {"a" => 1, "b" => 2, "c" => 3, "d" => 4, "e" => 5, "f" => 6, "g" => 7, "h" => 8}
$inv_key_mappings = $key_mappings.invert()

class Chess
    attr_accessor :board, :moves
    def initialize()
        @board = Board.new()
    end

    def run()
        print_intro
            
        while(true)
            input = gets.chomp

            if(input == "start")
                puts "Starting a new game..."
                start_game
                print_intro
            elsif(input == "help")
                print_help
            elsif(input == "exit")
                puts "There is no game to exit."
            elsif(input == "quit")
                puts "Quitting program..."
                exit(true)
            else
                puts "Your command could not be interpreted. Type 'help' for help."
            end
        end
    end

    def start_game()
        @board.init_board
        
        finished = false
        while(!finished)
            @board.print_board
            puts "Make your move, #{@board.get_next_player}"
            
            input = gets.chomp
            if(input == "start")
                puts "You are already playing a game. You must exit this game to be able to start a new."
            elsif(input == "help")
                print_help
            elsif(input == "exit")
                puts "Exiting current game..."
                finished = true
            elsif(input == "quit")
                puts "Quitting program..."
                exit(true)
            elsif(proper_move(input))
                from = [$key_mappings[input[0]], input[1].to_i]
                to = [$key_mappings[input[3]], input[4].to_i]

                @board.make_move(from, to)
                finished = board.victory_check()
            else
                puts "Your command could not be interpreted. Type 'help' for help."
            end
        end
    end

    def print_intro()
        puts "Welcome to Ruby chess! Below are the available commands"
        print_help
    end

    def print_help()
        puts " - start      Starts a new chess game. Move inputs are on the format 'from to'. For example: e2 e4"
        puts " - help       Lists the available commands."
        puts " - exit       Exits the current game."
        puts " - quit       Closes the program."
    end

    def proper_move(input)
        formats = input.length == 5 && input[2] == " "
        letters = letter?(input[0]) && letter?(input[3])
        numbers = numeric?(input[1]) && numeric?(input[4])

        return formats && letters && numbers
    end

    def letter?(symbol)
        symbol.match?(/[[:alpha:]]/)
    end

    def numeric?(symbol)
        symbol.match?(/[[:digit:]]/)
    end
end

###
game = Chess.new()
game.run