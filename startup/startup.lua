-- Function to recursively list all files in a directory
local function listFiles(dir)
    local list = fs.list(dir)
    local files = {}

    for _, file in ipairs(list) do
        local fullPath = fs.combine(dir, file)
        if fs.isDir(fullPath) then
            -- If it's a directory, recurse into it
            local subFiles = listFiles(fullPath)
            for _, subFile in ipairs(subFiles) do
                table.insert(files, subFile)
            end
        else
            -- It's a file, add it to the list
            table.insert(files, fullPath)
        end
    end

    return files
end

local function splitByPeriod(str)
    local result = {}
    for match in string.gmatch(str, "[^%.]+") do
        table.insert(result, match)
    end
    return result
end

local function getFileName(path)
    return string.match(path, "([^/\\]+)$")
end

-- Main
local dir = "/.bin/"

local files = listFiles(dir)
for _, file in ipairs(files) do
    shell.setAlias(splitByPeriod(getFileName(file))[1], file)
end
