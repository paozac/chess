module Chess
  # Internal board representation of a chess position. The move list belongs
  # to the `Game` class.
  #
  class Board
    # Use FEN pieces notation format. Lowercase is black, uppercase white.
    # I'm using a bottom-top representation for easier human visualization.
    #
    INITIAL_SETUP = [
      [:r,  :n,  :b,  :q,  :k,  :b,  :n,  :r ],
      [:p,  :p,  :p,  :p,  :p,  :p,  :p,  :p ],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [:P,  :P,  :P,  :P,  :P,  :P,  :P,  :P ],
      [:R,  :N,  :B,  :Q,  :K,  :B,  :N,  :R ]
    ]

    # Public: bidimensional array of the board squares
    #
    attr_accessor :squares

    def initialize(setup = INITIAL_SETUP)
      self.squares = setup
    end

    # Public: returns the FEN representation of the current board state. This
    # doesn't include the castling info and such.
    def to_fen
    end

    # Public: returns an ASCII table of the board state
    #
    def to_ascii
      out = "+-+-+-+-+-+-+-+-+\n"
      squares.each do |row|
        row.each do |square|
          out += "|#{square || ' '}"
        end
        out += "|\n+-+-+-+-+-+-+-+-+\n"
      end
      out
    end

    # Public: returns a board with the initial setup
    #
    def self.default
      new
    end

    # Converts a single rank to FEN format
    #
    #   rank - an array of pieces
    #
    # Returns a string
    def rank_to_fen(rank)
      out = ""
      empty = 0
      rank.each do |square|
        if square.nil?
          empty += 1
        else
          if empty > 0
            out += empty.to_s
            empty = 0
          end
          out += square.to_s
        end
      end
      out += empty.to_s if empty > 0
      out
    end
  end
end
