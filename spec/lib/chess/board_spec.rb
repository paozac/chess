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
end
