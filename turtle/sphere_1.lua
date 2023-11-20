local function runCommand(command)
    local success, message = shell.run(command)
    if not success then
        print("command failed: " .. (message or "unknown error"))
    end
end

-- Function to create a voxel sphere
function createVoxelSphere(radius)
    local sphere = {}
    for z = -radius, radius do
	local layer = {}
        for x = -radius, radius do
            for y = -radius, radius do
                if x^2 + y^2 + z^2 <= radius^2 then
                    -- Add voxel to the sphere if it's inside the radius
                    table.insert(layer, {x = x, y = y})
                end
            end
        end
        table.insert(sphere, {num = z, layer = layer})
    end
    return sphere
end

--- function printVoxelSphere(sphere)
---     for _, voxel in ipairs(sphere) do
---         print("Voxel: x=" .. voxel[1] .. ", y=" .. voxel[2] .. ", z=" .. voxel[3])
---     end
--- end

local args = {...}

-- Function to build a layer of the sphere
local function build(radius)
    for data in ipairs(createVoxelSphere(radius)) do
	print("layer " .. data.num)
        for _, point in ipairs(data.layer) do
            runCommand("./move_to.lua ".. point.x .. " " .. point.y)
            turtle.placeDown()
        end
	turtle.up()
    end
end

build(tonumber(args[1]))


