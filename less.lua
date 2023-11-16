-- Function to display content with scrolling
local function less(filePath)
    if not fs.exists(filePath) then
        print("File does not exist: " .. filePath)
        return
    end

    if fs.isDir(filePath) then
        print("Cannot open a directory: " .. filePath)
        return
    end

    local file = fs.open(filePath, "r")
    local lines = {}
    local line = file.readLine()
    while line do
        table.insert(lines, line)
        line = file.readLine()
    end
    file.close()

    local index = 1
    local pageSize = 20 -- Number of lines to show at once

    while true do
        term.clear()
        term.setCursorPos(1,1)

        for i = index, math.min(index + pageSize - 1, #lines) do
            print(lines[i])
        end

        print("\nPress 'Q' to quit, 'N' for next page, 'P' for previous page")
        local event, key = os.pullEvent("key")

        if key == keys.q then
            break
        elseif key == keys.n and index + pageSize <= #lines then
            index = index + pageSize
        elseif key == keys.p and index - pageSize > 0 then
            index = index - pageSize
        end
    end
end

-- Main
local args = {...}
if #args == 0 then
    print("Usage: less <filename>")
    return
end

local filePath = args[1]
less(filePath)
