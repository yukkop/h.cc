-- ComputerCraft script to dig a 5x5x5 hole

-- Initialize the turtle
local function initialize(x, y, z)
  -- Check if the turtle has enough fuel
  if turtle.getFuelLevel() < x * y * z then
    print("Not enough fuel. Add more and restart the script.")
    print("Fuel level " .. turtle.getFuelLevel() .. "; Need " .. x * y * z)
    return false
  end
  return true
end

-- Dig forward and move
local function digForward()
  while turtle.detect() do
    turtle.dig()
    sleep(0.5) -- Prevents getting stuck on gravel or sand
  end
  turtle.forward()
end

-- Dig down and move
local function digDown()
  while turtle.detectDown() do
    turtle.digDown()
    sleep(0.5)
  end
  turtle.down()
end

-- Main digging function
local function digHole(x, y, z)
  for depth = 1, y do
    for row = 1, z do
      for col = 1, x do
        digForward()
      end
      if row < z then -- Turn at the end of each row except the last
        if row % 2 == 1 then
          turtle.turnRight()
          digForward()
          turtle.turnRight()
        else
          turtle.turnLeft()
          digForward()
          turtle.turnLeft()
        end
      end
    end
    if depth < y then -- Move down after each layer
      digDown()
      if depth % 2 == 0 then -- Turn around after even layers
        turtle.turnRight()
        turtle.turnRight()
      end
    end
  end
end

local args = {...}
local x = tonumber(args[1])
local y = tonumber(args[2])
local z = tonumber(args[3])
-- Start the program
if initialize(x, y, z) then
  digHole(x, y, z)
end
