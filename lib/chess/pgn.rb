module Chess
  class Pgn
    # Public: The raw PGN data
    attr_accessor :raw_data

    # List of required and optional tags.
    # See http://en.wikipedia.org/wiki/Portable_Game_Notation
    #
    PGN_TAGS = [
      # Mandatory tags
      :event,
      :site,
      :date,
      :round,
      :white,
      :black,
      :result,
      # Optional tags
      :eventdate,
      :eco,
      :whiteelo,
      :blackelo,
      :plycount
    ]

    # Public: PGN tag accessors
    attr_accessor *PGN_TAGS

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
      tags = extract_tags
      tags.each_pair do |key, value|
        if PGN_TAGS.include?(key)
          self.send("#{key}=", value)
        end
      end
      self
    end

    private

      # Private: extracts the PGN tags (event, date, player names, etc).
      # PGN tag format is
      #
      #    [key "value"]
      #
      # Returns a hash in {property: value} format
      def extract_tags
        items = {}

        lines = raw_data.split("\n")
        lines.each do |line|
          regexp = Regexp.new('(\[\s*(?<key>\w+)\s*"(?<value>[^"]*)"\s*\]\s*)+')
          match_data = regexp.match(line)
          next unless match_data
          key = normalize_tag_label(match_data[:key])
          value = match_data[:value]
          items[key] = value
        end

        items
      end

      # Private: converts the tag label to a ruby-friendly symbol format
      #
      # Examples:
      #
      #    normalize_tag_label('Event')
      #    => :event
      #
      # Returns a symbol
      def normalize_tag_label(label)
        label.gsub(/[-\ ]/, '_').downcase.to_sym
      end
  end
end
