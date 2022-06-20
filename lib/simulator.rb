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
    begin
      command_type, *args = commands.split(' ')

      # Raise an exception if the command is not valid.
      if !COMMANDS.include?(command_type)
        raise ArgumentError, "Invalid command, valid commands are #{COMMANDS}"
      end

      # If the command is PLACE, then the arguments are the tabletop, the x, y, and facing.
      args = place_arguments(args) if command_type.eql?('PLACE')

      # Call the method on the robot.
      @robot.send(command_type.downcase, *args)
    rescue ArgumentError, TypeError => e
      e.message
    end
  end

  private

  # Returns the arguments for the PLACE command.
  # Raise an exception if the arguments are not valid.
  def place_arguments(args)
    begin
      tokens = args.join.split(',')

      [@tabletop, Integer(tokens[0]), Integer(tokens[1]), tokens[2]]
    rescue
      raise ArgumentError, 'Invalid PLACE arguments, requires X and Y position and facing direction'
    end
  end
end
