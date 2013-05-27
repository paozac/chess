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

    # Public: returns a board with the initial setup
    #
    def self.default
      new
    end
  end
end
