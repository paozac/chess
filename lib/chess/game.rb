module Chess
  class Game
    attr_accessor :event, :site, :date

    # Public: array of moves
    attr_accessor :moves

    # Public: current move index, 0 is the first move index
    attr_accessor :current_move_index

    # Public: a board setups array indexed by move
    attr_accessor :board_setups

    def initialize
      @board_setups = [Board::INITIAL_SETUP]
      @current_move_index = 0
    end

    # Public: resets the move counter
    #
    # Returns self
    def restart
      @current_move_index = 0
      self
    end

    # Public: returns the current move
    def current_move
      moves[@current_move_index]
    end

    # Public: returns the next move and updates the current_move counter
    #
    def next_move
      last_move = total_moves - 1
      i = @current_move_index + 1
      i = last_move if i >= last_move
      @current_move_index = i
      build_setup(i)
      moves[i]
    end

    # Public: returns the previous move and updates the current_move counter
    #
    def previous_move
      i = @current_move_index - 1
      i = 0 if i < 0
      @current_move_index = i
      moves[i]
    end

    # Public: Returns the piece setup for the current position
    #
    # Returns a bidimensional array
    def current_setup
      @board_setups[@current_move_index]
    end

    # Public: total number of moves
    #
    def total_moves
      moves.size
    end

    # Private: adds a board setup entry for the current move
    #
    # Returns the current setup
    def build_setup(move_index)
      return board_setups[move_index] if board_setups[move_index]
    end

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
