require 'spec_helper'

describe Chess::Game do
  describe ".load_from_pgn" do
    let(:data) { File.read 'spec/fixtures/deep_blue_kasparov_1997.pgn' }

    before do
      @game = described_class.load_from_pgn(data)
    end

    it "returns a Game object" do
      expect(@game).to be_kind_of(Chess::Game)
    end

    it "loads the move list" do
      expect(@game.moves).to be_kind_of(Array)
      expect(@game.moves.size).to eq(90)
    end
  end

  describe "move navigation" do
    before do
      @game = described_class.new
      @game.moves = ['d4', 'd5', 'e4', 'e5']
    end

    describe "initial position" do
      it "current_move should be 0" do
        expect(@game.current_move_index).to eq(0)
      end
    end

    describe "#next_move" do
      it "advances the move index" do
        move = @game.next_move
        expect(move).to eq 'd5'
        expect(@game.current_move_index).to eq(1)
      end
    end

    describe "restart" do
      it "resets the move counter" do
                                   # d4
        @game.next_move            # d5
        @game.next_move            # e4
        @game.next_move            # e5
        move = @game.previous_move # e4
        expect(move).to eq 'e4'
        expect(@game.current_move_index).to eq(2)
      end
    end
  end
end
