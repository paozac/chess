module Chess
  # PGN move processor
  #
  class PgnMove
    # Public: the PGN move string
    attr_accessor :string

    # Initializer. Moves make sense only in the context of a setup
    #
    # PgnMove.new('c6', setup)
    def initialize(move, setup = nil)
      raise "No move provided" if move.blank?
      @setup = setup
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
