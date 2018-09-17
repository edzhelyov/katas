require './lib/rover.rb'

RSpec.describe '#test' do
  let(:initial_position) { Position.new(0, 0, 'N') }
  let(:grid) { Grid.new(10, 10) }

  it 'starts with position 0,0,N' do
    rover = Rover.new(initial_position, grid)

    rover.position.x.should eq initial_position.x
    rover.position.y.should eq initial_position.y
    rover.position.direction.should eq initial_position.direction

    rover.grid.x.should eq grid.x
    rover.grid.y.should eq grid.y
  end

  it 'moves one position' do
    rover = Rover.new(initial_position, grid)
    newPosition = rover.execute('M')

    newPosition.should eq '0,1,N'
  end

  it 'rotates right moves one position rotates right moves one position' do
    rover = Rover.new(initial_position, grid)
    newPosition = rover.execute('RMLMM')

    newPosition.should eq '1,2,N'
  end

  it 'goes to opposite direction when reaching x end of grid' do
    rover = Rover.new(Position.new(9, 0, 'E'), grid)
    newPosition = rover.execute('M')

    newPosition.should eq '9,0,W'
  end

  it 'goes to opposite direction when reaching y end of grid' do
    rover = Rover.new(Position.new(0, 9, 'N'), grid)
    newPosition = rover.execute('M')

    newPosition.should eq '0,9,S'
  end

  it 'goes to opposite direction when reaching x 0 of grid' do
    rover = Rover.new(Position.new(0, 0, 'W'), grid)
    newPosition = rover.execute('M')

    newPosition.should eq '0,0,E'
  end

  it 'goes to opposite direction when reaching y 0 of grid' do
    rover = Rover.new(Position.new(0, 0, 'S'), grid)
    newPosition = rover.execute('M')

    newPosition.should eq '0,0,N'
  end

  it 'stops and reports obstacle' do
    rover = Rover.new(initial_position, grid, [Coordinate.new(0, 2)])
    newPosition = rover.execute('MM')

    newPosition.should eq 'O,0,1,N'
  end
end
