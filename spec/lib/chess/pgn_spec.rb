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

    describe "PGN tag extraction" do
      it "extracts the event name" do
        expect(@parser.event).to eq("IBM Man-Machine, New York USA")
      end

      it "extracts the game site" do
        expect(@parser.site).to eq("02")
      end

      it "extracts the game date" do
        expect(@parser.date).to eq("1997.??.??")
      end

      it "extracts the game event date" do
        expect(@parser.eventdate).to eq("?")
      end

      it "extracts the game round" do
        expect(@parser.round).to eq("?")
      end

      it "extracts the game result" do
        expect(@parser.result).to eq("1-0")
      end

      it "extracts the game white player" do
        expect(@parser.white).to eq("Deep Blue (Computer)")
      end

      it "extracts the game black player" do
        expect(@parser.black).to eq("Garry Kasparov")
      end

      it "extracts the game ECO" do
        expect(@parser.eco).to eq("C93")
      end

      it "extracts the game white ELO" do
        expect(@parser.whiteelo).to eq("?")
      end

      it "extracts the game black ELO" do
        expect(@parser.blackelo).to eq("?")
      end

      it "extracts the game ply count" do
        expect(@parser.plycount).to eq("89")
      end
    end
  end
end
