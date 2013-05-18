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
      :event_date,
      :eco,
      :white_elo,
      :black_elo,
      :ply_count
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

    # Public: returns a memoized array of moves in this format:
    #
    # [
    #   ['e4', 'e5'],
    #   ['Nf3', 'Nc6'],
    #   ...
    #   ['Ra6', '1-0']
    # ]
    #
    # Returns an array
    def moves
      @move_list ||= extract_moves
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
        label.underscore.to_sym
      end

      # Private: extracts the move list from the PGN data. Deals with single
      # and multiple line formats.
      #
      # Returns a bidimensional array
      def extract_moves
        lines = if multiline_move_list?
          extract_move_lines
        else
          tokenize_single_line_move_list
        end
        lines.map{|line| split_line(line)}.compact
      end

      # Private: filters out the non-blank and non-tags PGN lines
      #
      # Returns a line array
      def extract_move_lines
        @move_lines ||= raw_data.split("\n").
                        reject(&:blank?).
                        reject {|line| line.starts_with?('[')}
      end

      # Private: figures out if the move list is expressed in one line or more
      #
      # Returns a boolean
      def multiline_move_list?
        extract_move_lines.size > 1
      end

      # Private: breaks up the single line in multiple items. Returns the same
      # output you'd get with a multi-line move list.
      #
      # TODO: This is bad code. Use a regexp, this implementation works only
      # with a perfect format - no space after the move number etc.
      #
      # Returns an array of strings
      def tokenize_single_line_move_list
        out = []
        tokens = extract_move_lines.first.split(' ')

        tokens.each_with_index do |item, idx|
          out << "#{item} #{tokens[idx + 1]}" if idx % 2 == 0
        end
        out
      end

      # Private: Extracts the two moves from the single line
      #
      # Example:
      #
      #   split_line('1.e4 e5')
      #   => ['e4', 'e5']
      #
      # Returns an array
      def split_line(line)
        regexp = /(\d+\.)([^ ]+)(\s+([^ ]+))?/
        match_data = regexp.match(line)

        [match_data[2], match_data[4]] if match_data
      end
  end
end
