module Chess
  # PGN move processor
  #
  class PgnMove
    # Public: the PGN move string
    attr_accessor :string

    # Initializer
    #
    # PgnMove.new('c6')
    def initialize(move)
      raise "No move provided" if move.blank?
      self.string = move.strip
    end

    # Public: move type. Can be one of:
    #
    #   :castle_short
    #   :castle_long
    #
    # Returns a symbol
    def type
      case string
      when 'O-O'
        :castle_short
      when 'O-O-O'
        :castle_long
      end
    end
  end
end
