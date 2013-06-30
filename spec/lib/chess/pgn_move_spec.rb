require 'spec_helper'

describe Chess::PgnMove do
  describe ".new" do
    it "should raise an exception if the move string is missing" do
      expect { PgnMove.new('') }.to raise_exception
    end
  end

  describe ".type" do
    context "O-O" do
      it "should be :castle_short" do
        expect(described_class.new("O-O").type).to eq(:castle_short)
      end
    end

    context "O-O-O" do
      it "should be :castle_long" do
        expect(described_class.new("O-O-O").type).to eq(:castle_long)
      end
    end
  end
end
