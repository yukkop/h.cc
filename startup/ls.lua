-- Function to list all elements in a directory
local function list(dir)
    local dirs = {}
    local files = {}

    local items = fs.list(dir)
    for _, item in ipairs(items) do
        if fs.isDir(fs.combine(dir, item)) then
            table.insert(dirs, item)
        else
            table.insert(files, item)
        end
    end

    term.setTextColor(colors.green)
    for _, dir in ipairs(dirs) do
        write(dir .. " ")
    end
    term.setTextColor(colors.white)

    for _, file in ipairs(files) do
        write(file .. " ")
    end
end

local function listH(dir)
    local dirs = {}
    local files = {}

    local items = fs.list(dir)
    for _, item in ipairs(items) do
        if fs.isDir(fs.combine(dir, item)) then
            table.insert(dirs, item)
        else
            table.insert(files, item)
        end
    end

    term.setTextColor(colors.green)
    for _, dir in ipairs(dirs) do
        print(dir)
    end
    term.setTextColor(colors.white)

    for _, file in ipairs(files) do
        print(file)
    end
end

map = {
    all = {short = "a", long = "all", description = ""}
    long = {short = "l", long = "long", description = "more info"}
    help = {short = "h", long = "help", description = "not yet"}
}

-- 
local function splitIntoChars(str)
    local chars = {}
    for char in string.gmatch(str, ".") do
        table.insert(chars, char)
    end
    return chars
end

local function fingShortByLong(long)
    for key, value in pairs(map) do
       if value.long == option then
           return value.short
       end
    end

    return nil
end

-- Main
local programPath = arg[0];
local options = {} -- allways short
local args = {...}

for i, arg in ipairs(args) do
    if string.sub(arg, 1, 2) == "--" then
        local long_option = string.sub(arg, 3)
	
	local short_option = fingShortByLong(long_option)
	if short_option == nil then
	    print("Error")
	    os.exit()
	end

	table.insert(options, short_option)
    else
	if string.sub(arg, 1, 1) == "-" then
            local options_string = string.sub(arg, 2)
	    local short_options = splitIntoChars(options_string)
	    for _, short_option in ipairs(short_options) do
	        table.insert(options, short_option)
	    end
	end
    end
end


-- Function to find a value in the map
local function ifShortExist(map, targetValue)
    for key, value in pairs(map) do
        if value.short == targetValue then
            return true
        end
    end
    return false
end

local dir = shell.dir()

if ifShortExist(options, "a") then -- --all
    print("option a")
end

if ifShortExist(options, "l") then -- --long
    listH(dir)
    return
end

list(dir)
