class Tabletop
  attr_accessor :x_unit, :y_unit

  ORIENTATION = {
    'NORTH' => {
      facing_left: 'WEST',
      facing_right:'EAST',
      x_movement: 0,
      y_movement: 1
    },
    'EAST' => {
      facing_left: 'NORTH',
      facing_right:'SOUTH',
      x_movement: 1,
      y_movement: 0
    },
    'SOUTH' => {
      facing_left: 'EAST',
      facing_right:'WEST',
      x_movement: 0,
      y_movement: -1
    },
    'WEST' => {
      facing_left: 'SOUTH',
      facing_right:'NORTH',
      x_movement: -1,
      y_movement: 0
    },
  }

  # Tabletop with a default dimension of 5x5 units.
  def initialize(x_unit: 5, y_unit: 5)
    raise TypeError, 'Invalid dimensions' unless x_unit.is_a? Integer and y_unit.is_a? Integer

    @x_unit = x_unit
    @y_unit = y_unit
  end

  # Returns the direction that an entity would be facing after a turn.
  def get_direction(direction, face)
    return unless valid_direction?(direction)

    ORIENTATION[direction][face]
  end

  # Returns the coordinates that an entity would be at after a move.
  # If the movement would lead to the entity falling off the table,
  # the current positions are returned
  def get_coordinates(direction, x_position, y_position)
    return unless valid_direction?(direction)

    x_coordinate = x_position + ORIENTATION[direction][:x_movement]
    y_coordinate = y_position + ORIENTATION[direction][:y_movement]

    return [x_coordinate, y_coordinate] if valid_position?(x_coordinate, y_coordinate, direction)

    [x_position, y_position]
  end

  # Returns a boolean indicating whether or not the coordinates and direction are valid.
  def valid_position?(x_position, y_position, direction)
    valid_coordinates?(x_position, y_position) && valid_direction?(direction)
  end

  private

  # Returns a boolean indicating whether or not the direction is valid.
  def valid_direction?(direction)
    raise TypeError, 'Invalid direction' unless direction.is_a?(String)

    ORIENTATION.keys.include?(direction)
  end

  # Returns a boolean indicating whether or not the coordinates are valid.
  def valid_coordinates?(x_position, y_position)
    raise TypeError, 'Invalid coordinates' unless x_position.is_a? Integer and y_position.is_a? Integer

    x_position.between?(0, @x_unit) && y_position.between?(0, @y_unit)
  end
end
