# Toy Robot Simulator

It is a Ruby 3.0.4 app running in Docker.

## Getting Started

The application can be built, run and tested using Docker.
It requires `Docker` to be installed.
I have provided a `Makefile` for ease of running the Docker commands.

## Usage

To get you in the simulator, to interact with the toy robot.

    $ make build run

To run the tests in a docker container

    $ make build test

To shell in Docker and manually execute simulator, or do anything inside docker container.

    $ make build shell

If you don't want to use Docker and have Ruby already installed, you can do:

    $ bundle install
    $ ruby -I lib bin/toy-robot-simulator

And unit tests can also be run:

    $ rspec spec

# Specification

## Description

The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5 units x 5 units. There are no other obstructions on the table surface. The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.

An application that can read in commands of the following form:

```plain
PLACE X,Y,F
MOVE
LEFT
RIGHT
REPORT
```

- `PLACE` will put the toy robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
- The origin (0,0) can be considered to be the SOUTH WEST most corner.
- The first valid command to the robot is a PLACE command, after that, any sequence of commands may be issued, in any order, including another PLACE command. The application should discard all commands in the sequence until a valid PLACE command has been executed.
- `MOVE` will move the toy robot one unit forward in the direction it is currently facing.
- `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified direction without changing the position of the robot.
- `REPORT` will announce the X,Y and orientation of the robot.
- A robot that is not on the table can choose to ignore the MOVE, LEFT, RIGHT and REPORT commands.

## Constraints

The toy robot must not fall off the table during movement. This also includes the initial placement of the toy robot.
Any move that would cause the robot to fall must be ignored.

## Example Input and Output

### Example 1

```plain
PLACE 0,0,NORTH
MOVE
REPORT
Output: 0,1,NORTH
```

### Example 2

```plain
PLACE 0,0,NORTH
LEFT
REPORT
Output: 0,0,WEST
```

### Example 3

```plain
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
Output: 3,3,NORTH
```
