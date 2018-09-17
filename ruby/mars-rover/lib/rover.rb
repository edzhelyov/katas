require_relative './rover/coordinate.rb'
require_relative './rover/position.rb'
require_relative './rover/grid.rb'
require_relative './rover/obstacle_error.rb'

module Rover
  class Rover
    attr_accessor :position, :grid, :obstacles

    def initialize(pos, grid, obstacles = nil)
      @position = pos
      @grid = grid
      @obstacles = obstacles
    end

    def execute(commands)
      commands = commands.split('')
      commands.each do |command|
        move if command == 'M'
        @position.rotate(command) unless command == 'M'
      end
      @position.to_s
    rescue ObstacleError
      "O,#{@position}"
    end

    private

    def out_of_range?(next_coordinate)
      next_coordinate.x >= @grid.x || next_coordinate.x.negative? ||
        next_coordinate.y >= @grid.y || next_coordinate.y.negative?
    end

    def obstacle?(next_coordinate)
      obstacles&.find { |obstacle| obstacle.x == next_coordinate.x && obstacle.y == next_coordinate.y }
    end

    def move
      next_coordinate = Position.new(@position.x, @position.y, @position.direction)
      next_coordinate.y = @position.y + 1 if @position.direction == 'N'
      next_coordinate.y = @position.y - 1 if @position.direction == 'S'
      next_coordinate.x = @position.x + 1 if @position.direction == 'E'
      next_coordinate.x = @position.x - 1 if @position.direction == 'W'

      if out_of_range?(next_coordinate)
        @position.rotate('L')
        @position.rotate('L')
      elsif obstacle?(next_coordinate)
        raise ObstacleError
      else
        @position = next_coordinate
      end
    end
  end
end
