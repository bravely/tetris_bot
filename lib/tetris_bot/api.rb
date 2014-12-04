require 'tetris_bot'

module TetrisBot
  class Api
    attr_accessor :gamestate

    def initialize(options = {})
      @width = options[:width] || 10
      @height = options[:height] || 20
      @gamestate = options[:gamestate] || default_gamestate
    end

    def default_gamestate
      # Array goes from top to bottom
      gamestate = []
      @height.times do
        gamestate << "0" * @width
      end
      gamestate
    end
  end
end