require 'spec_helper'

describe Chess::Pgn do
  describe ".parse" do
    let(:data) { File.read 'spec/fixtures/deep_blue_kasparov_1997.pgn' }

    before do
      @parser = Chess::Pgn.parse(data)
    end

    it "returns a Pgn instance" do
      expect(@parser).to be_kind_of(Chess::Pgn)
    end

    it "stores the raw data locally" do
      expect(@parser.raw_data).to eq(data)
    end
  end
end
