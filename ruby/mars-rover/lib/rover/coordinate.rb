module Rover
  class Coordinate
    attr_accessor :x, :y

    def initialize(x_coordinate, y_coordinate)
      @x = x_coordinate
      @y = y_coordinate
    end
  end
end
