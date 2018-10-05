# MyBot

**TODO: Add description**

## Installation

- Clone the Directory
- Run `mix deps.get` to ensure MyBot is up-to date
- Start within the parent folder with `iex -S mix`
- Play and have fun!

## Description
-----------

- The application is a simulation of a toy robot moving on a square tabletop,
  of dimensions 5 units x 5 units.
- There are no other obstructions on the table surface.
- The robot is free to roam around the surface of the table, but must be
  prevented from falling to destruction. Any movement that would result in the
  robot falling from the table must be prevented, however further valid
  movement commands are still allowed.

## Moves
- `PLACE X,Y,F`
  Example: `PLACE 1 2 N` will place the robot on the board at 1,2 Facing North
- `MOVE` Move Forwards one pace
- `LEFT` Turn 90* Left
- `RIGHT` Turn Right 90*
- `REPORT` Return Current Location
