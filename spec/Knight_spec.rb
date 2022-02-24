require './lib/Board'
require './lib/Move'
require './lib/Piece'
require './lib/Pieces/Knight'

describe Knight do
    before(:all) do
        @board = Board.new
        @board.clear_board

        @white_knight1 = Knight.new("White", [3, 3])
        @white_knight2 = Knight.new("White", [5, 4])

        @black_knight1 = Knight.new("Black", [2, 5])

        @board.put_piece(@white_knight1)
        @board.put_piece(@white_knight2)
        @board.put_piece(@black_knight1)
    end

=begin
        The built example board:
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   | B |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   | W |   |   |   |
        ---------------------------------
        |   |   | W |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
=end

    # White knight 1
    describe "Possible moves" do
        it "Tests unreachable squares white knight1 [3, 3]" do
            expect(@white_knight1.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_knight1.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_knight1.possible_move?(@board, [3, 3])).to be(false)
            expect(@white_knight1.possible_move?(@board, [3, 5])).to be(false)
            expect(@white_knight1.possible_move?(@board, [5, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for white knight1 [3, 3]" do
            expect(@white_knight1.possible_move?(@board, [5, 4])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white knight1 [3, 3]" do
            expect(@white_knight1.possible_move?(@board, [1, 2])).to be(true)
            expect(@white_knight1.possible_move?(@board, [2, 1])).to be(true)
            expect(@white_knight1.possible_move?(@board, [4, 5])).to be(true)
            expect(@white_knight1.possible_move?(@board, [4, 1])).to be(true)
        end
    end

    describe "Possible moves" do
        it "Tests the available capture for the white knight1 [3, 3]" do
            expect(@white_knight1.possible_move?(@board, [2, 5])).to be(true)
        end
    end

    # White knight 2
    describe "Possible moves" do
        it "Tests unreachable squares white knight2 [3, 3]" do
            expect(@white_knight2.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_knight2.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_knight2.possible_move?(@board, [5, 2])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for white knight2 [3, 3]" do
            expect(@white_knight2.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white knight2 [3, 3]" do
            expect(@white_knight2.possible_move?(@board, [4, 2])).to be(true)
            expect(@white_knight2.possible_move?(@board, [6, 2])).to be(true)
            expect(@white_knight2.possible_move?(@board, [7, 3])).to be(true)
            expect(@white_knight2.possible_move?(@board, [7, 5])).to be(true)
            expect(@white_knight2.possible_move?(@board, [6, 6])).to be(true)
            expect(@white_knight2.possible_move?(@board, [3, 5])).to be(true)
        end
    end

    # Black knight 1
    describe "Possible moves" do
        it "Tests unreachable squares black knight1 [2, 5]" do
            expect(@black_knight1.possible_move?(@board, [0, 4])).to be(false)
            expect(@black_knight1.possible_move?(@board, [0, 6])).to be(false)
            expect(@black_knight1.possible_move?(@board, [2, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the black knight1 [2, 5]" do
            expect(@black_knight1.possible_move?(@board, [4, 6])).to be(true)
            expect(@black_knight1.possible_move?(@board, [3, 7])).to be(true)
            expect(@black_knight1.possible_move?(@board, [1, 3])).to be(true)
            expect(@black_knight1.possible_move?(@board, [4, 4])).to be(true)
        end
    end

    describe "Possible moves" do
        it "Tests the available capture for the black knight1 [2, 5]" do
            expect(@black_knight1.possible_move?(@board, [3, 3])).to be(true)
        end
    end
end