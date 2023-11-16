-- Function to build a sphere using an octree algorithm
function buildSphere(radius)
    local function recurse(x, y, z, size)
        local distance = math.sqrt(x^2 + y^2 + z^2)

        if distance <= radius then
            turtle.select(1) 
            turtle.digDown()
            turtle.placeDown()
        end

        if size > 1 then
            local newSize = size / 2
            recurse(x - newSize, y, z, newSize)
            recurse(x + newSize, y, z, newSize)
            recurse(x, y - newSize, z, newSize)
            recurse(x, y + newSize, z, newSize)
            recurse(x, y, z - newSize, newSize)
            recurse(x, y, z + newSize, newSize)
        end
    end

    -- Move the turtle to the starting position
    turtle.up()
    turtle.forward()

    -- Build the sphere using the octree algorithm
    recurse(0, 0, 0, radius)
end

function refillFuel()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel > 0 then
        return
    end

    local function tryRefuel()
        for i = 1, 16 do
            if turtle.getItemCount(i) > 0 then
                turtle.select(i)
                if turtle.refuel(1) then
                    return true
                end
            end
        end
        return false
    end

    if not tryRefuel() then
        print("Add more fuel to continue.")
        while not tryRefuel() do
            os.pullEvent("turtle_inventory")
        end
        print("Resuming...")
    end
end

refillFuel()

local args = {...}
-- Set the radius of the sphere
local sphereRadius = tonumber(args[1])

-- Build the sphere
buildSphere(sphereRadius)
