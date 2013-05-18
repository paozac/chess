module Chess
  class Pgn
    # Public: The raw PGN data
    attr_accessor :raw_data

    PGN_ATTRIBUTES = [
      :event, :site, :date
    ]
    # Public: PGN event attributes
    attr_accessor *PGN_ATTRIBUTES

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
      metadata = extract_metadata
      metadata.each_pair do |key, value|
        if PGN_ATTRIBUTES.include?(key)
          self.send("#{key}=", value)
        end
      end
      self
    end

    private

      # Private: extracts the PGN metadata (event, date, player names, etc).
      # PGN metadata format is
      #
      #    [key "value"]
      #
      # Returns a hash in {property: value} format
      def extract_metadata
        items = {}

        lines = raw_data.split("\n")
        lines.each do |line|
          regexp = Regexp.new('(\[\s*(?<key>\w+)\s*"(?<value>[^"]*)"\s*\]\s*)+')
          match_data = regexp.match(line)
          next unless match_data
          key = normalize_metadata_label(match_data[:key])
          value = match_data[:value]
          items[key] = value
        end

        items
      end

      # Private: converts the metadata label to a standard symbol format
      #
      # Examples:
      #
      #    normalize_metadata_label('Event')
      #    => :event
      #
      # Returns a symbol
      def normalize_metadata_label(label)
        label.gsub(/[-\ ]/, '_').downcase.to_sym
      end
  end
end
