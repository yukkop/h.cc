-- Function to create a voxel sphere
function createVoxelSphere(radius)
    local sphere = {}
    for x = -radius, radius do
        for y = -radius, radius do
            for z = -radius, radius do
                if x^2 + y^2 + z^2 <= radius^2 then
                    -- Add voxel to the sphere if it's inside the radius
                    table.insert(sphere, {x, y, z})
                end
            end
        end
    end
    return sphere
end

function printVoxelSphere(sphere)
    for _, voxel in ipairs(sphere) do
        print("Voxel: x=" .. voxel[1] .. ", y=" .. voxel[2] .. ", z=" .. voxel[3])
    end
end

local args = {...}

printVoxelSphere(createVoxelSphere(tonumber(args[1])))
