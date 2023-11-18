-- Function to refuel the turtle
local function refuelTurtle()
    local fuelLevel = turtle.getFuelLevel()

    -- Check if the turtle needs refueling
    if fuelLevel == "unlimited" or fuelLevel > 0 then
        return true
    end

    -- Iterate through each inventory slot
    for slot = 1, 16 do
        turtle.select(slot) -- Select the slot
        if turtle.refuel(1) then -- Attempt to refuel from this slot
            return true
        end
    end

    return false -- No valid fuel found
end

-- Calling the refuel function
if refuelTurtle() then
    print("Refueled successfully.")
else
    print("Unable to find fuel.")
end
