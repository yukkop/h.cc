function generateBlocks(radius, middle)
    local radiusSq = radius * radius
    local halfSize, size, offset

    if middle then
        size = 2 * math.ceil(radius) + 1
        offset = math.floor(size / 2)
    else
        halfSize = math.ceil(radius) + 1
        size = halfSize * 2
        offset = halfSize - 0.5
    end

    local function isFull(x, y, z)
        x = x - offset
        y = y - offset
        z = z - offset
        x = x * x
        y = y * y
        z = z * z

        return x + y + z < radiusSq
    end

    local blocks = {}

    for z = 1, size do
        local slice = blocks[z] or {}
        blocks[z] = slice
        -- print("Blocks: ", blocks[z])

        for x = 1, size do
            local row = slice[x] or {}
            slice[x] = row
            -- print("Slice: ", slice[x])

            for y = 1, size do
                row[y] = isFull(x, y, z)
                -- print("Row: ", row[y])
            end
        end
    end

    return blocks
end

function purgeBlocks(blocks)
    local newblocks = {}

    for z, slice in ipairs(blocks) do
        local newslice = newblocks[z] or {}
        newblocks[z] = newslice

        for x, row in ipairs(slice) do
            local newrow = newslice[x] or {}
            newslice[x] = newrow

            for y, value in ipairs(row) do
                newrow[y] = value and (not row[y - 1] or not row[y + 1] or not slice[x - 1][y] or not slice[x + 1][y] or not blocks[z - 1][x][y] or not blocks[z + 1][x][y])
            end
        end
    end

    return newblocks
end

function extractCoordinates(blocks)
    local coordinates = {}

    for z, slice in ipairs(blocks) do
        for x, row in ipairs(slice) do
            for y, value in ipairs(row) do
                if value then
                    -- Insert a table with coordinates (x, y) into the dictionary using z as the key
                    if not coordinates[z] then
                        coordinates[z] = {}
                    end
                    table.insert(coordinates[z], {x, y})
                end
            end
        end
    end

    return coordinates
end

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

if fs.exists("./move_to.log") then
    runCommand("rm ./move_to.log")
end
local file = io.open("move_to.log", "w")

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
	else
	    turnRight(dif)
        end
    end
    if from < to then
	local dif = to - from 
        if dif == 3 then
            log("->> RIGHT")
	    turtle.turnRight()
	else
	    turnLeft(dif)
        end
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

-- You can implement other functions similarly

-- Example usage:
local radius = tonumber(5)
local fill = false
-- local hints = isChecked('chkHints')
local middle = false
local blocks = generateBlocks(radius, middle)
local coordinates = extractCoordinates(blocks)

turtle.select(1)

-- Print the dictionary
for z, coords in pairs(coordinates) do
    -- io.write("z: " .. z .. ", Coordinates: { ")
    for _, coord in ipairs(coords) do
        moveTo(coord[1], coord[2])
        turtle.placeDown()
        -- io.write("(" .. coord[1] .. ", " .. coord[2] .. ") ")
    end
    -- io.write("}\n")
end

-- if not fill then
--     blocks = purgeBlocks(blocks)
-- end

-- print("Blocks list:", ipairs(blocks))
-- for key, value in pairs(blocks) do
--     -- print(key, value)
--     for key1, value1 in pairs(value) do
--         for key2, value2 in pairs(value1) do
--             print(key2, value2)
--         end
--     end
-- end