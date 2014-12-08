require 'tetris_bot/version'
require 'tetris_bot/api'

module TetrisBot
  def choice
    placed = false

    gamestate.reverse.each_with_index do |row, y|
      row.each_with_index do |point, x|
        if !placed && fits?(gamestate, current_shape, y, x)
          case
          when x == cursor_x
            break
          when x < cursor_x
            (cursor_x - x).times { cursor_left }
          when x > cursor_x
            (x - cursor_x).times { cursor_right }
          end
          down
          placed = true
        end
      end
    end
  end

  private

  def fits?(gamestate, current_shape, pos_y, pos_x)
    pass = true
    current_shape.shape.reverse.each_with_index do |shape_row, shape_y|
      shape_row.each_with_index do |present, shape_x|
        pass = false if present && gamestate[pos_y - shape_y][pos_x + shape_x]
      end
    end

    pass
  end

end
