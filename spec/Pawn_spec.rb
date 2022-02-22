require './lib/Board'
require './lib/Move'
require './lib/Piece'
require './lib/Pieces/Pawn'

describe Piece do
    before(:all) do

=begin
        The built example board:
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   | W |   |   |   |
        ---------------------------------
        | W | B | B | B |   |   |   |   |
        ---------------------------------
        |   |   | W |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
=end

        @board = Board.new
        @board.clear_board

        @white_pawn1 = Pawn.new("White", [3,3])
        @white_pawn1.moves = 1 # Disables forward move 2, lets black_pawn3 passant this pawn

        @white_pawn2 = Pawn.new("White", [5,5])
        @white_pawn2.moves = 2

        @white_pawn3 = Pawn.new("White", [1,4])
        @white_pawn3.moves = 1

        @black_pawn1 = Pawn.new("Black", [3,4])
        @black_pawn1.moves = 1

        @black_pawn2 = Pawn.new("Black", [4,4])
        @black_pawn2.moves = 2
        
        @black_pawn3 = Pawn.new("Black", [2,4])
        @black_pawn3.moves = 2

        @board.put_piece(@white_pawn1)
        @board.put_piece(@white_pawn2)
        @board.put_piece(@white_pawn3)
        @board.put_piece(@black_pawn1)
        @board.put_piece(@black_pawn2)
        @board.put_piece(@black_pawn3)

        @board.moves.append(Move.new(@white_pawn3, [1, 2], [1, 4]))
    end


    describe "Possible moves" do
        it "Tests the unavailable moves for the white pawn1 [3, 3]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    unless (x == 2 && y == 4) || (x == 4 && y == 4)
                        expect(@white_pawn1.possible_move?(@board, [x, y])).to be(false)
                    end
                end
            end
        end
    end

    describe "Possible moves" do
        it "Tests the availability of capture for the white pawn1 [3, 3]" do
            expect(@white_pawn1.possible_move?(@board, [2, 4])).to be(true)
            expect(@white_pawn1.possible_move?(@board, [4, 4])).to be(true)
        end
    end

    describe "Possible moves" do
        it "Tests the unavailable moves for the white pawn2 [5, 5]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    unless x == 5 && y == 6
                        if(@white_pawn2.possible_move?(@board, [x, y]))
                            puts "x: #{x}, y: #{y}"
                        end
                        expect(@white_pawn2.possible_move?(@board, [x, y])).to be(false)
                    end
                end
            end
        end
    end

    describe "Possible moves" do
        it"Tests the available moves for the white pawn2 [5, 5]" do
            expect(@white_pawn2.possible_move?(@board, [5, 6])).to be(true)
        end
    end

    describe "Possible moves" do
        it"Tests the unavailable moves for the white pawn3 [1, 4]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    unless x == 1 && y == 5
                        expect(@white_pawn3.possible_move?(@board, [x, y])).to be(false)
                    end
                end
            end
        end
    end

    describe "Possible moves" do
        it"Tests the available moves for the white pawn3 [1, 4]" do
            expect(@white_pawn3.possible_move?(@board, [1, 5])).to be(true)
        end
    end

    describe "Possible moves" do
        it"Tests the unavailabile moves for the black pawn [3, 4]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    expect(@black_pawn1.possible_move?(@board, [x, y])).to be(false)
                end
            end
        end
    end

    describe "Possible moves" do
        it"Tests the unavailable moves for the black pawn [4, 4]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    unless (x == 3 && y == 3) || (x == 4 && y == 3)
                        expect(@black_pawn2.possible_move?(@board, [x, y])).to be(false)
                    end
                end
            end
        end
    end

    describe "Possible moves" do
        it"Tests the available moves for the black pawn [5, 5]" do
            expect(@black_pawn2.possible_move?(@board, [3, 3])).to be(true)
            expect(@black_pawn2.possible_move?(@board, [4, 3])).to be(true)
        end
    end

    describe "Possible moves" do
        it"Tests the unavailable moves for the black pawn [2, 4]" do
            (1..8).each do |x|
                (1..8).each do |y|
                    unless (x == 1 && y == 3) || (x == 2 && y == 3) || (x == 3 && y == 3)
                        expect(@black_pawn3.possible_move?(@board, [x, y])).to be(false)
                    end
                end
            end
        end
    end

    describe "Possible moves" do
        it"Test passant for black pawn3 [2, 4]" do
            expect(@black_pawn3.possible_move?(@board, [1, 3])).to be(true)
        end
    end

    describe "Possible moves" do
        it"Test move forward for black pawn3 [2, 4]" do
            expect(@black_pawn3.possible_move?(@board, [2, 3])).to be(true)
        end
    end

    describe "Possible moves" do
        it"Test capture for black pawn3 [2, 4]" do
            expect(@black_pawn3.possible_move?(@board, [3, 3])).to be(true)
        end
    end
end