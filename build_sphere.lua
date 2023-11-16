-- Function to build a sphere using an octree algorithm
function build_upper_sphere(radius)
    local diameter = radius * 2

    for x = -radius, radius do
        for y = -radius, radius do
            local decision = x*x + y*y - radius*radius + (1 - radius)
            if decision <= 0 then
                local z = math.sqrt(radius * radius - x * x - y * y)
                turtle.up(z)
                turtle.placeDown()
                turtle.down(z)
            end
        end
    end
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
build_upper_sphere(sphereRadius)
