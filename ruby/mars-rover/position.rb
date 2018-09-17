class Position < Coordinate
    attr_accessor :direction
    def initialize(x, y, direction)
        super(x,y)
        @direction = direction
    end

    def rotate(direction)
        directions = ['N','E','S','W']
        index = directions.find_index(@direction)
        new_index = direction == 'R' ? index + 1 : index - 1
        new_index = 3 if new_index < 0
        new_index = 0 if new_index > 4
        @direction = directions[new_index]
    end

    def to_s
        "#{@x},#{y},#{@direction}"
    end
end