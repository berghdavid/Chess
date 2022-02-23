require './lib/Board'
require './lib/Piece'
Dir["./lib/Pieces/*.rb"].each {|file| require file }

describe Board do
    subject(:board) { Board.new }
    describe Board do
        # Pawns
        it "Test Pawns positioning" do
            (1..8).each do |x|
                expect(board.get_piece([x,2]).class).to eql(Pawn)
                expect(board.get_piece([x,7]).class).to eql(Pawn)
            end
        end

        # Rooks
        it "Test Rooks positioning" do
            expect(board.get_piece([1,1]).class).to eql(Rook)
            expect(board.get_piece([8,1]).class).to eql(Rook)
            expect(board.get_piece([1,8]).class).to eql(Rook)
            expect(board.get_piece([8,8]).class).to eql(Rook)
        end
        
        # Knights
        it "Test Knights positioning" do
            expect(board.get_piece([2,1]).class).to eql(Knight)
            expect(board.get_piece([7,1]).class).to eql(Knight)
            expect(board.get_piece([2,8]).class).to eql(Knight)
            expect(board.get_piece([7,8]).class).to eql(Knight)
        end

        # Bishops
        it "Test Bishops positioning" do
            expect(board.get_piece([3,1]).class).to eql(Bishop)
            expect(board.get_piece([6,1]).class).to eql(Bishop)
            expect(board.get_piece([3,8]).class).to eql(Bishop)
            expect(board.get_piece([6,8]).class).to eql(Bishop)
        end

        # Queens
        it "Test Queens positioning" do
            expect(board.get_piece([4,1]).class).to eql(Queen)
            expect(board.get_piece([4,8]).class).to eql(Queen)
        end

        # Kings
        it "Test Kings positioning" do
            expect(board.get_piece([5,1]).class).to eql(King)
            expect(board.get_piece([5,8]).class).to eql(King)
        end

        it "Test colors of white pieces" do
            (1..8).each do |x|
                (1..2).each do |y|
                    expect(board.get_piece([x,y]).color).to eql("White")
                end
            end
        end

        it "Test colors of black pieces" do
            (1..8).each do |x|
                (7..8).each do |y|
                    expect(board.get_piece([x,y]).color).to eql("Black")
                end
            end
        end

        it "Test empty squares" do
            (1..8).each do |x|
                (3..6).each do |y|
                    expect(board.get_piece([x,y])).to eql(nil)
                end
            end
        end

        it "Test put method" do
            pos = [5, 5]
            test_piece = Pawn.new("White", pos)
            board.put_piece(test_piece)

            expect(board.get_piece(pos)).to eql(test_piece)
        end
    end
end