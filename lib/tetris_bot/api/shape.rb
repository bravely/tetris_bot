require 'tetris_bot'

class Api
  class Shape
    attr_reader :name
    attr_reader :shape
    attr_reader :height
    attr_reader :width

    def initialize(options = {})
      square
    end

    def square
      @name = 'square'
      @shape = [
        [true, true],
        [true, true]
      ]
      @height = @shape.length
      @width = @shape.first.length
    end
  end
end
