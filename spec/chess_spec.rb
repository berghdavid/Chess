require './lib/Chess'
require './lib/Piece'
require './lib/Player'
require './lib/Board'

describe Board do
    subject(:game) { Chess.new }
    describe "#init" do
        xit "returns the sum of two numbers" do
            calculator = Calculator.new
            expect(calculator.add(5, 2)).to eql(7)
          end
    end
end

describe Piece do
    subject(:piece) { Piece.new("white", [1,2]) }
    subject(:board) { Board.new }

    describe "#get_pos" do
        xit "returns the position of the piece" do
            expect(piece.get_pos).to be([1,2])
          end
    end

    describe "#possible_move?" do
        xit "Tests the availability of the move" do
            expect(board.possible_move?([1,2],[3,3])).to be(true)
        end
    end

    describe "#possible_move?" do
        xit "Tests the availability of the move" do
            expect(board.possible_move?([1,2],[4,3])).to be(false)
        end
    end
end