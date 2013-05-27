require 'spec_helper'

describe Chess::Board do
  describe "#to_fen" do
    pending
  end

  describe ".default" do
    subject { described_class.default }

    it "returns a Board object" do
      expect(subject).to be_kind_of(Chess::Board)
    end

    it "stores the default setup" do
      expect(subject.squares).to eq(Chess::Board::INITIAL_SETUP)
    end
  end

  describe "#to_ascii" do
    it "returns a nicely formatted ascii table" do
      expect(described_class.default.to_ascii).to eq(
        "+-+-+-+-+-+-+-+-+\n" +
        "|r|n|b|q|k|b|n|r|\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "|p|p|p|p|p|p|p|p|\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "| | | | | | | | |\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "| | | | | | | | |\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "| | | | | | | | |\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "| | | | | | | | |\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "|P|P|P|P|P|P|P|P|\n" +
        "+-+-+-+-+-+-+-+-+\n" +
        "|R|N|B|Q|K|B|N|R|\n" +
        "+-+-+-+-+-+-+-+-+\n"
      )
    end
  end

  describe "#rank_to_fen" do
    let(:board) { Chess::Board.new }

    it "formats a string with the pieces" do
      pieces = [:r, :n, :b, :q, :k, :b, :n, :r]
      expect(board.rank_to_fen(pieces)).to eq("rnbqkbnr")
    end

    it "splats empty squares" do
      pieces = [:r, nil, nil, :q, nil, :b, :n, :r]
      expect(board.rank_to_fen(pieces)).to eq("r2q1bnr")
    end

    it "splats empty squares" do
      pieces = [nil, nil, nil, nil, nil, nil, nil, nil]
      expect(board.rank_to_fen(pieces)).to eq("8")
    end
  end
end
