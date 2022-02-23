require './lib/Board'
require './lib/Move'
require './lib/Piece'
require './lib/Pieces/Rook'

describe Rook do
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
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   | B |   |   |   |   |
        ---------------------------------
        |   |   | W | W |   |   | B |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
=end

        @board = Board.new
        @board.clear_board

        @white_rook1 = Rook.new("White", [3, 3])
        @white_rook2 = Rook.new("White", [4, 3])

        @black_rook1 = Rook.new("Black", [4, 4])
        @black_rook2 = Rook.new("Black", [7, 3])

        @board.put_piece(@white_rook1)
        @board.put_piece(@white_rook2)
        @board.put_piece(@black_rook1)
        @board.put_piece(@black_rook2)
    end

    # White rook 1
    describe "Possible moves" do
        it "Tests unreachable squares white rook1 [3, 3]" do
            expect(@white_rook1.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_rook1.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_rook1.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for white rook1 [3, 3]" do
            expect(@white_rook1.possible_move?(@board, [4, 3])).to be(false)
            expect(@white_rook1.possible_move?(@board, [5, 3])).to be(false)
            expect(@white_rook1.possible_move?(@board, [6, 3])).to be(false)
            expect(@white_rook1.possible_move?(@board, [7, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white rook1 [3, 3]" do
            (1..2).each do |x|
                expect(@white_rook1.possible_move?(@board, [x, 3])).to be(true)
            end

            (1..8).each do |y|
                if(y != 3)
                    expect(@white_rook1.possible_move?(@board, [3, y])).to be(true)
                end
            end
        end
    end

    # White rook 2
    describe "Possible moves" do
        it "Tests unreachable squares white rook2 [4, 3]" do
            expect(@white_rook2.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_rook2.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_rook2.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of white blockade for white rook2 [4, 3]" do
            expect(@white_rook2.possible_move?(@board, [3, 3])).to be(false)
            expect(@white_rook2.possible_move?(@board, [2, 3])).to be(false)
            expect(@white_rook2.possible_move?(@board, [1, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of black blockade for white rook2 [4, 3]" do
            expect(@white_rook2.possible_move?(@board, [8, 3])).to be(false)
            expect(@white_rook2.possible_move?(@board, [4, 5])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white rook2 [4, 3]" do
            (5..7).each do |x|
                expect(@white_rook2.possible_move?(@board, [x, 3])).to be(true)
            end

            (1..4).each do |y|
                if(y != 3)
                    expect(@white_rook2.possible_move?(@board, [4, y])).to be(true)
                end
            end
        end
    end

    # Black rook 1
    describe "Possible moves" do
        it "Tests unreachable squares for black rook1 [4, 4]" do
            expect(@black_rook1.possible_move?(@board, [1, 1])).to be(false)
            expect(@black_rook1.possible_move?(@board, [2, 2])).to be(false)
            expect(@black_rook1.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for black rook1 [4, 4]" do
            expect(@black_rook1.possible_move?(@board, [4, 2])).to be(false)
            expect(@black_rook1.possible_move?(@board, [4, 1])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the black rook1 [4, 4]" do
            (1..8).each do |x|
                if(x != 4)
                    expect(@black_rook1.possible_move?(@board, [x, 4])).to be(true)
                end
            end

            (3..8).each do |y|
                if(y != 4)
                    expect(@black_rook1.possible_move?(@board, [4, y])).to be(true)
                end
            end
        end
    end

    # Black rook 2
    describe "Possible moves" do
        it "Tests unreachable squares for black rook2 [4, 4]" do
            expect(@black_rook2.possible_move?(@board, [1, 1])).to be(false)
            expect(@black_rook2.possible_move?(@board, [2, 2])).to be(false)
            expect(@black_rook2.possible_move?(@board, [6, 6])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for black rook1 [4, 4]" do
            expect(@black_rook2.possible_move?(@board, [1, 3])).to be(false)
            expect(@black_rook2.possible_move?(@board, [2, 3])).to be(false)
            expect(@black_rook2.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the black rook1 [4, 4]" do
            (4..8).each do |x|
                if(x != 7)
                    expect(@black_rook2.possible_move?(@board, [x, 3])).to be(true)
                end
            end

            (1..8).each do |y|
                if(y != 3)
                    expect(@black_rook2.possible_move?(@board, [7, y])).to be(true)
                end
            end
        end
    end
end