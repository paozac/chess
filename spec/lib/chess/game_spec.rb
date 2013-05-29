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
end
