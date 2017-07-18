# frozen_string_literal: true

require './colorize'

# aswesome robot
class Robot
  attr_reader :x, :y, :facing, :min_x, :max_x, :min_y, :max_y
  FACINGS = %w[NORTH EAST SOUTH WEST].freeze
  class WrongFacing < StandardError; end

  def initialize(min_x, max_x, min_y, max_y)
    @min_x = min_x
    @max_x = max_x
    @min_y = min_y
    @max_y = max_y
  end

  def execute_command(raw_command)
    command = raw_command.split(' ')
    command_name = command.shift.downcase
    args = (command[0] || '').split(',')
    return not_on_the_table unless check_on_the_table || command_name == 'place'
    public_send(command_name, *args)
  end

  def place(x, y, facing)
    x = Integer(x)
    y = Integer(y)
    return almost_fell unless check_limits(x, y)
    @x = x
    @y = y
    @facing = FACINGS.include?(facing) ? facing : raise(WrongFacing)
  end

  def move
    case @facing
    when 'NORTH'
      place(x, y + 1, facing)
    when 'SOUTH'
      place(x, y - 1, facing)
    when 'EAST'
      place(x + 1, y, facing)
    when 'WEST'
      place(x - 1, y, facing)
    end
  end

  def left
    @facing = FACINGS[FACINGS.index(@facing) - 1]
  end

  def right
    @facing = FACINGS[FACINGS.index(@facing) + 1] || FACINGS[0]
  end

  def report
    puts "#{@x}, #{@y}, #{@facing}".green
  end

  private

  def check_limits(x, y)
    x >= min_x && x <= max_x && y >= min_y && y <= max_y
  end

  def check_on_the_table
    @x && @y && @facing
  end

  def almost_fell
    puts "Wow, Master, I've almost fell! Please be careful!".red
  end

  def not_on_the_table
    puts "Master, please put me on the table, I can't do it =(".yellow
  end
end
