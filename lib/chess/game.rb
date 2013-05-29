module Chess
  class Game
    attr_accessor :event, :site, :date

    # Public: array of moves
    attr_accessor :moves

    # Public: creates a game object from a PGN-formatted string
    #
    # text - the PGN string
    #
    # Examples
    #
    #   Game.load_from_pgn(File.read('game.pgn'))
    #
    # Returns the game
    def self.load_from_pgn(text)
      pgn = Pgn.parse(text)
      game = new
      game.moves = pgn.moves
      game
    end
  end
end
