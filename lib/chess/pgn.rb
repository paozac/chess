module Chess
  class Pgn
    # Public: The raw PGN data
    attr_accessor :raw_data

    # Public: parses a PGN string
    #
    # text - a PGN string
    #
    # Returns a Pgn object
    def self.parse(text)
      parser = new
      parser.parse(text)
    end

    # Public: parses a PGN string and extracts its data
    #
    # text - a PGN string
    #
    # Returns self, to allow a fluent interface
    def parse(text)
      self.raw_data = text
      self
    end
  end
end
