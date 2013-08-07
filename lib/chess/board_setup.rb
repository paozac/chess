module Chess
  # Helper object to deal with the internal board representation
  #
  class BoardSetup
    # Use FEN pieces notation format. Lowercase is black, uppercase white.
    # I'm using a bottom-top representation for easier human visualization.
    #
    INITIAL = [
      [:r,  :n,  :b,  :q,  :k,  :b,  :n,  :r ],
      [:p,  :p,  :p,  :p,  :p,  :p,  :p,  :p ],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [nil, nil, nil, nil, nil, nil, nil, nil],
      [:P,  :P,  :P,  :P,  :P,  :P,  :P,  :P ],
      [:R,  :N,  :B,  :Q,  :K,  :B,  :N,  :R ]
    ]

    attr_accessor :setup

    def initialize(setup = INITIAL)
      @setup = clone_bidimensional_array(setup)
    end

    # Returs a deep copy
    def clone
      self.class.new(setup.map(&:dup))
    end

    def ranks
      setup
    end

    # Smart comparison. Allows comparison between BoardSetup objects and board
    # setup expressed as a bidimensional array
    def ==(other)
      if other.kind_of?(Array)
        other == setup
      else
        other.setup == self.setup
      end
    end

    private

    # Deep copy
    def clone_bidimensional_array(a)
      a.map(&:dup)
    end
  end
end
