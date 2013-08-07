require 'spec_helper'

describe Chess::Game do
  let(:data) { File.read 'spec/fixtures/deep_blue_kasparov_1997.pgn' }

  describe ".load_from_pgn" do
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

  describe "#current_setup" do
    it "returns an array with the current position" do
      expect(described_class.new.current_setup).to eq(Chess::BoardSetup::INITIAL)
    end

    pending "follows the game moves" do
      game = described_class.load_from_pgn(data)
      game.next_move
      expect(game.current_setup).to eq(
        [
          [:r,  :n,  :b,  :q,  :k,  :b,  :n,  :r ],
          [:p,  :p,  :p,  :p,  :p,  :p,  :p,  :p ],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [nil, :P,  nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil, nil],
          [:P,  nil, :P,  :P,  :P,  :P,  :P,  :P ],
          [:R,  :N,  :B,  :Q,  :K,  :B,  :N,  :R ]
        ]
      )
    end
  end

  describe "#build_setup" do
    it "returns the correct setup" do
      game = described_class.load_from_pgn(data)
      expect(game.build_setup(0).ranks).to eq(Chess::BoardSetup::INITIAL)
    end
  end
end
