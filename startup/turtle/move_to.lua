-- Turtle script to build a sphere

-- Directions
local Directions = {
    NORTH = 1, -- -y
    WEST = 2 -- -x
    SOUTH = 3, -- +y
    EAST = 4, -- +x
}

local args = {...}

-- TODO inline arg
local direction = Directions.NORTH

local pos = {x = 0, y = 0}

-- Function to calculate the points of a circle for a given radius
local function calculateCirclePoints(radius)
    -- Implement the midpoint circle algorithm or a similar algorithm
    -- to return a list of points (x, y) for the circle
    {0, 0}
end

-- Function to move the Turtle to a specific point
local function moveTo(x, y)
    -- move from pos -> x, y
    xBias = x - pos.x
    yBias = y - pos.y
    xDist = math.abs(xBias)
    yDist = math.abs(yBias)
	
    -- EAST
    if xBias > 0 then
        rotate(direction, Direction.EAST)
    else -- WEST
        rotate(direction, Direction.WEST)
    end
    turtle.forward(xDist)

    -- SOUTH
    if yBias > 0 then
        rotate(direction, Direction.SOUTH)
    else -- NORTH
        rotate(direction, Direction.NORTH)
    end
    turtle.forward(yDist)

end

local function rotate(from, to)
    if from > to then
	local dif = from - to 
        if dif == 3 then
	    turtle.turnLeft()
        end
	turnRight(dif)
    end
    if from > to then
	local dif = to - from 
        if dif == 3 then
	    turtle.turnRight()
        end
	turnLeft(dif)
    end
end

local function turnLeft(n) 
    for i = 1, n do
        turtle.turnLeft()
    end
end

local function turnRight(n) 
    for i = 1, n do
        turtle.turnRight()
    end
end

local x = tonumber(args[1])
local y = tonumber(args[2])

moveTo(x, y)
