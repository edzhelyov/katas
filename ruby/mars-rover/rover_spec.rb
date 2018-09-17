require './rover.rb'
require './coordinate.rb'
require './position.rb'
require './grid.rb'
require './obstacle_error.rb'

RSpec.describe "#test" do
    let(:initialPosition) { Position.new(0,0,'N') }
    let(:grid) { Grid.new(10,10) }

    it 'starts with position 0,0,N' do
        rover = Rover.new(initialPosition, grid)

        expect(rover.position.x).to eq(initialPosition.x)
        expect(rover.position.y).to eq(initialPosition.y)
        expect(rover.position.direction).to eq(initialPosition.direction)

        expect(rover.grid.x).to eq(grid.x)
        expect(rover.grid.y).to eq(grid.y)
    end

    it 'moves one position' do
        rover = Rover.new(initialPosition, grid)
        newPosition = rover.execute('M')

        expect(newPosition).to eq("0,1,N")
    end

    it 'rotates right moves one position rotates right moves one position' do
        rover = Rover.new(initialPosition, grid)
        newPosition = rover.execute('RMLMM')

        expect(newPosition).to eq("1,2,N")
    end

    it 'goes to opposite direction when reaching x end of grid' do
        rover = Rover.new(Position.new(9,0,'E'), grid)
        newPosition = rover.execute('M')

        expect(newPosition).to eq("9,0,W")
    end

    it 'goes to opposite direction when reaching y end of grid' do
        rover = Rover.new(Position.new(0,9,'N'), grid)
        newPosition = rover.execute('M')

        expect(newPosition).to eq("0,9,S")
    end

    it 'goes to opposite direction when reaching x 0 of grid' do
        rover = Rover.new(Position.new(0,0,'W'), grid)
        newPosition = rover.execute('M')

        expect(newPosition).to eq("0,0,E")
    end

    it 'goes to opposite direction when reaching y 0 of grid' do
        rover = Rover.new(Position.new(0,0,'S'), grid)
        newPosition = rover.execute('M')

        expect(newPosition).to eq("0,0,N")
    end

    it 'stops and reports obstacle' do
        rover = Rover.new(initialPosition, grid, [Coordinate.new(0,2)])
        newPosition = rover.execute('MM')

        expect(newPosition).to eq("O,0,1,N")
    end
    
end