module Rover
  class Position < Rover::Coordinate
    attr_accessor :direction

    def initialize(x_coordinate, y_coordinate, direction)
      super(x_coordinate, y_coordinate)
      @direction = direction
    end

    def rotate(direction)
      directions = %w(N E S W)
      index = directions.find_index(@direction)
      new_index = direction == 'R' ? index + 1 : index - 1
      new_index = 3 if new_index.negative?
      new_index = 0 if new_index > 3
      @direction = directions[new_index]
    end

    def to_s
      "#{@x},#{@y},#{@direction}"
    end
  end
end
