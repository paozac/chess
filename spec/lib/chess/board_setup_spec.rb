require 'spec_helper'

describe Chess::BoardSetup do
  describe "#==" do
    it "compares BoardSetup objects" do
      a = described_class.new
      b = described_class.new
      expect(a == b).to be_true
    end

    it "compares BoardSetup objects and setup arrays" do
      a = described_class.new
      b = described_class::INITIAL
      expect(a == b).to be_true
    end

    it "returns false for different setups" do
      a = described_class.new
      a.setup[0][0] = nil
      b = described_class::INITIAL
      expect(a == b).to be_false
    end
  end
end
