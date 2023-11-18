-- Turtle script to build a sphere

-- Directions
local Direction = {
    NORTH = 1, -- -y
    WEST = 2, -- -x
    SOUTH = 3, -- +y
    EAST = 4 -- +x
}

local args = {...}

-- TODO inline arg
local direction = Direction.NORTH

local pos = {x = 0, y = 0}

local file = io.open("filename.txt", "w")

local function log(mess)
   print(mess)
   if file then
	file:write(mess .. "\n")
   end
end

local function turnLeft(n) 
    for i = 1, n do
        log("->> LEFT")
        turtle.turnLeft()
    end
end

local function turnRight(n) 
    for i = 1, n do
        log("->> RIGHT")
        turtle.turnRight()
    end
end

local function rotate(from, to)
    log("from " .. from .. " to " .. to)
    if from > to then
	local dif = from - to 
        if dif == 3 then
            log("->> LEFT")
	    turtle.turnLeft()
        end
	turnRight(dif)
    end
    if from < to then
	local dif = to - from 
        if dif == 3 then
            log("->> RIGHT")
	    turtle.turnRight()
        end
	turnLeft(dif)
    end

    direction = to
end

local function forward(n) 
    for i = 1, n do
        log("->> FORWARD")
        turtle.forward()
    end
end

-- Function to move the Turtle to a specific point
local function moveTo(x, y)
    -- move from pos -> x, y
    xBias = x - pos.x
    yBias = y - pos.y
    log("bias " .. "{" .. xBias .. ";" .. yBias .. "}" )
    xDist = math.abs(xBias)
    yDist = math.abs(yBias)
	
    -- EAST
    if xBias > 0 then
	log("to EAST")
        rotate(direction, Direction.EAST)
    else -- WEST
	log("to WEST")
        rotate(direction, Direction.WEST)
    end
    forward(xDist)

    -- SOUTH
    if yBias > 0 then
	log("to SOUTH")
        rotate(direction, Direction.SOUTH)
    else -- NORTH
	log("to NORTH")
        rotate(direction, Direction.NORTH)
    end
    forward(yDist)

end

local x = tonumber(args[1])
local y = tonumber(args[2])

moveTo(x, y)
file:close()
