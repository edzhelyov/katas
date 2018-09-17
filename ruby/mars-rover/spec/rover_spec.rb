require 'spec_helper.rb'
require 'rover.rb'

RSpec.describe 'Rover' do
  let(:initial_position) { Rover::Position.new(0, 0, 'N') }
  let(:grid) { Rover::Grid.new(10, 10) }

  it 'starts with position 0,0,N' do
    rover = Rover::Rover.new(initial_position, grid)

    rover.position.x.should eq initial_position.x
    rover.position.y.should eq initial_position.y
    rover.position.direction.should eq initial_position.direction

    rover.grid.x.should eq grid.x
    rover.grid.y.should eq grid.y
  end

  it 'should move one position in Y coordinate with command "M"' do
    rover = Rover::Rover.new(initial_position, grid)
    new_position = rover.execute('M')

    new_position.should eq '0,1,N'
  end

  it 'should rotates right moves one position rotate left move two positions with command "RMLMM"' do
    rover = Rover::Rover.new(initial_position, grid)
    new_position = rover.execute('RMLMM')

    new_position.should eq '1,2,N'
  end

  it 'should rotate to West direction when reach the East end of X coordinate' do
    rover = Rover::Rover.new(Rover::Position.new(9, 0, 'E'), grid)
    new_position = rover.execute('M')

    new_position.should eq '9,0,W'
  end

  it 'should rotate to South direction when reach the North end of Y coordinate' do
    rover = Rover::Rover.new(Rover::Position.new(0, 9, 'N'), grid)
    new_position = rover.execute('M')

    new_position.should eq '0,9,S'
  end

  it 'should rotate to East direction when reach the West beginning of X coordinate' do
    rover = Rover::Rover.new(Rover::Position.new(0, 0, 'W'), grid)
    new_position = rover.execute('M')

    new_position.should eq '0,0,E'
  end

  it 'should rotate to North direction when reach the South beginning of Y coordinate' do
    rover = Rover::Rover.new(Rover::Position.new(0, 0, 'S'), grid)
    new_position = rover.execute('M')

    new_position.should eq '0,0,N'
  end

  it 'should stop and report obstacle when reach one' do
    rover = Rover::Rover.new(initial_position, grid, [Rover::Coordinate.new(0, 2)])
    new_position = rover.execute('MM')

    new_position.should eq 'O,0,1,N'
  end
end
