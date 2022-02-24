require './lib/Board'
require './lib/Move'
require './lib/Piece'
require './lib/Pieces/Bishop'

describe Bishop do
    before(:all) do
        @board = Board.new
        @board.clear_board

        @white_bishop1 = Bishop.new("White", [3, 3])
        @white_bishop2 = Bishop.new("White", [5, 5])
        @white_bishop3 = Bishop.new("White", [3, 2])

        @black_bishop1 = Bishop.new("Black", [2, 2])

        @board.put_piece(@white_bishop1)
        @board.put_piece(@white_bishop2)
        @board.put_piece(@black_bishop1)
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
        |   |   |   |   | W |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
        |   |   | W |   |   |   |   |   |
        ---------------------------------
        |   | B | W |   |   |   |   |   |
        ---------------------------------
        |   |   |   |   |   |   |   |   |
        ---------------------------------
=end

    # White bishop 1
    describe "Possible moves" do
        it "Tests unreachable squares white bishop1 [3, 3]" do
            expect(@white_bishop1.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [3, 2])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [2, 3])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [7, 8])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [0, -5])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for white bishop1 [3, 3]" do
            expect(@white_bishop1.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [5, 5])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [6, 6])).to be(false)
            expect(@white_bishop1.possible_move?(@board, [7, 7])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white bishop1 [3, 3]" do
            expect(@white_bishop1.possible_move?(@board, [4, 4])).to be(true)
            expect(@white_bishop1.possible_move?(@board, [4, 2])).to be(true)
            expect(@white_bishop1.possible_move?(@board, [2, 4])).to be(true)
            expect(@white_bishop1.possible_move?(@board, [1, 5])).to be(true)
        end
    end

    describe "Possible moves" do
        it "Tests the available capture for the white bishop1 [3, 3]" do
            expect(@white_bishop1.possible_move?(@board, [2, 2])).to be(true)
        end
    end

    # White bishop 2
    describe "Possible moves" do
        it "Tests unreachable squares white bishop2 [5, 5]" do
            expect(@white_bishop2.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [3, 2])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [2, 3])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [7, 8])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [0, 0])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests unreachable squares because of blockade for white bishop2 [5, 5]" do
            expect(@white_bishop2.possible_move?(@board, [1, 1])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the white bishop2 [5, 5]" do
            expect(@white_bishop2.possible_move?(@board, [4, 4])).to be(true)
            expect(@white_bishop2.possible_move?(@board, [6, 6])).to be(true)
            expect(@white_bishop2.possible_move?(@board, [6, 4])).to be(true)
            expect(@white_bishop2.possible_move?(@board, [4, 6])).to be(true)
        end
    end

    # White bishop 3
    describe "Possible moves" do
        it "Tests unreachable squares white bishop3 [3, 2]" do
            expect(@white_bishop2.possible_move?(@board, [2, 2])).to be(false)
            expect(@white_bishop2.possible_move?(@board, [3, 3])).to be(false)
        end
    end

    # Black bishop 1
    describe "Possible moves" do
        it "Tests unreachable squares black bishop1 [2, 2]" do
            expect(@black_bishop1.possible_move?(@board, [2, 2])).to be(false)
            expect(@black_bishop1.possible_move?(@board, [1, 2])).to be(false)
            expect(@black_bishop1.possible_move?(@board, [2, 1])).to be(false)
            expect(@black_bishop1.possible_move?(@board, [5, 4])).to be(false)
            expect(@black_bishop1.possible_move?(@board, [0, 0])).to be(false)
        end
    end

    describe "Possible moves" do
        it "Tests the available moves for the black bishop1 [2, 2]" do
            expect(@black_bishop1.possible_move?(@board, [1, 1])).to be(true)
            expect(@black_bishop1.possible_move?(@board, [1, 3])).to be(true)
            expect(@black_bishop1.possible_move?(@board, [3, 1])).to be(true)
        end
    end

    describe "Possible moves" do
        it "Tests the available capture for the black bishop1 [2, 2]" do
            expect(@black_bishop1.possible_move?(@board, [3, 3])).to be(true)
        end
    end
end