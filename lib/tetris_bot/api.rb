require 'tetris_bot'
require 'tetris_bot/api/shape'

class Api
  attr_accessor :gamestate
  attr_accessor :cursor_x
  attr_accessor :current_shape
  attr_reader :width
  attr_reader :height

  def initialize(options = {})
    @width = options[:width] || 10
    @height = options[:height] || 20
    @gamestate = options[:gamestate] || default_gamestate
    @cursor_x = options[:cursor_x] || 4 # Position 5 of 10
    @current_shape = Shape.new(shape_name: options[:shape_name])
  end

  def default_gamestate
    # Array goes from top to bottom
    gamestate = []
    @height.times do
      row = []
      @width.times { row << false }
      gamestate << row
    end
    gamestate
  end

  def cursor_right
    @cursor_x += 1 if @cursor_x != ((@width - @current_shape.width) - 1)
  end

  def cursor_left
    @cursor_x -= 1 if @cursor_x != 0
  end

  def down
    piece_down = false
    # Gamestate top to bottom
    @gamestate.each_with_index do |row, i|        
      # Check shape, bottom to top
      @current_shape.shape.reverse.each_with_index do |shape_row, shape_y|

        # Check shape row, left to right
        shape_row.each_with_index do |shape_attr, shape_x|
          if shape_attr && @gamestate[(i - shape_y).abs][cursor_x + shape_x]
            if i == 0
              puts 'You Lost'
            else
              submit_shape(i - 1)
              piece_down = true
            end
          end
        end
      end
    end 
    submit_shape(@gamestate.length - 1) unless piece_down
  end

  private

  def submit_shape(start_row)
    @current_shape.shape.reverse.each_with_index do |shape_row, shape_y|
      shape_row.each_with_index do |shape_attr, shape_x|
        @gamestate[start_row - shape_y][cursor_x + shape_x] = true if shape_attr
      end
    end
  end
end