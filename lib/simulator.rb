require 'robot'
require 'tabletop'

class Simulator
  COMMANDS = [
    'PLACE',
    'LEFT',
    'RIGHT',
    'MOVE',
    'REPORT'
  ]

  attr_accessor :robot, :tabletop

  def initialize(input: ARGF, robot: Robot.new, tabletop: Tabletop.new)
    @input = input
    @robot = robot
    @tabletop = tabletop
  end

  def start
    puts 'Toy Robot Simulator!'
    puts 'type EXIT to quit'

    @input.each do |line|
      line.strip!

      break if line.downcase.eql?('exit')
      next if line.empty?

      result = execute(line)
      puts result if result
    end
  end

  def execute(commands)
    command_type, *args = commands.split(' ')

    # Raise an exception if the command is not valid.
    raise ArgumentError, 'Invalid command' unless COMMANDS.include?(command_type)

    # If the command is PLACE, then the arguments are the tabletop, the x, y, and facing.
    args = place_arguments(args) if command_type.eql?('PLACE')

    begin
      # Call the method on the robot.
      @robot.send(command_type.downcase, *args)
    rescue ArgumentError, TypeError
      # Ignore the error if not valid.
    rescue => e
      return e.message
    end
  end

  private

  # Returns the arguments for the PLACE command.
  def place_arguments(args)
    tokens = args.join.split(',')

    return [@tabletop, Integer(tokens[0]), Integer(tokens[1]), tokens[2]]
  end
end
