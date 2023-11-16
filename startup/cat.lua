-- Function to display the contents of a file
local function cat(filePath)
    if not fs.exists(filePath) then
        print("File does not exist: " .. filePath)
        return
    end

    if fs.isDir(filePath) then
        print("Cannot cat a directory: " .. filePath)
        return
    end

    local file = fs.open(filePath, "r")
    local content = file.readAll()
    file.close()

    print(content)
end

-- Main
local args = {...}
if #args == 0 then
    print("Usage: cat <filename> [<filename2> ...]")
    return
end

for _, filePath in ipairs(args) do
    cat(filePath)
    if _ < #args then
        print() -- Print a newline between files
    end
end
