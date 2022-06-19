class Robot
  attr_accessor :x_position, :y_position, :direction

  # Places robot at position x, y, facing cardinal direction.
  def place(tabletop, x_position, y_position, direction)
    return unless tabletop.valid_position?(x_position, y_position, direction)

    @tabletop = tabletop
    @direction = direction
    @x_position = x_position
    @y_position = y_position

    nil
  end

  # Advances the robot one position in the direction it is currently facing.
  def move
    if @tabletop
      @x_position, @y_position = @tabletop.get_coordinates(@direction, @x_position, @y_position)
    end

    nil
  end

  # Rotates robot 90° counter-clockwise.
  def left
    if @tabletop
      @direction = @tabletop.get_direction(@direction, :facing_left)
    end

    nil
  end

  # Rotates robot 90° clockwise.
  def right
    if @tabletop
      @direction = @tabletop.get_direction(@direction, :facing_right)
    end

    nil
  end

  # Prints the current location.
  # i.e. "Output: x,y,direction"
  def report
    return unless @tabletop

    output = [@x_position, @y_position, @direction]

    "Output: #{output.join(',')}"
  end
end
