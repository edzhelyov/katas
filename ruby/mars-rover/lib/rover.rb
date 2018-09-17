require "./lib/coordinate.rb"
require "./lib/position.rb"
require "./lib/grid.rb"
require "./lib/obstacle_error.rb"

class Rover
  attr_accessor :position, :grid, :obstacles

  def initialize(pos, grid, obstacles = nil)
    @position = pos
    @grid = grid
    @obstacles = obstacles
  end

  def execute(commands)
    begin
      commands = commands.split('')
      commands.each do |command|
        move if command == 'M'
        @position.rotate(command) unless command == 'M'
      end
      @position.to_s
    rescue ObstacleError
      "O,#{@position.to_s}"
    end
  end

  private

  def is_out_of_range(next_coordinate)
    next_coordinate.x >= @grid.x || next_coordinate.x < 0 || next_coordinate.y >= @grid.y || next_coordinate.y < 0
  end

  def is_obstacle(next_coordinate)
    obstacles && obstacles.find { |obstacle| obstacle.x == next_coordinate.x && obstacle.y == next_coordinate.y }
  end

  def move
    next_coordinate = Position.new(@position.x, @position.y, @position.direction)
    next_coordinate.y = @position.y + 1 if @position.direction == 'N'
    next_coordinate.y = @position.y - 1 if @position.direction == 'S'
    next_coordinate.x = @position.x + 1 if @position.direction == 'E'
    next_coordinate.x = @position.x - 1 if @position.direction == 'W'

    if is_out_of_range(next_coordinate)
      @position.rotate('L')
      @position.rotate('L')
    elsif is_obstacle(next_coordinate)
      raise ObstacleError
    else
      @position = next_coordinate
    end
  end
end
