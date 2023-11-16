-- Function to list all elements in a directory
local function list(dir)
    local items = fs.list(dir)
    for _, item in ipairs(items) do
        print(item)
    end
end

map = {
    all = {short = 'a', long = "all", description = "show all"}
}

-- Function to find a string in the map
local function findInMap(map, target)
    for key, tuple in pairs(map) do
        for _, value in ipairs(tuple) do
            if value == target then
                return key, value
            end
        end
    end
    return nil, nil -- Not found
end

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
local args = [...]

for i, arg in ipairs(args) do
    if string.sub(arg, 1, 2) == "--" then
        local long_option = string.sub(arg, 3)
	
	local short_option = fingShortByLong(long_option)
	if short_option == nil then
	    print("Error")
	    os.exit()
	end

	table.insert(options, short_option)
    else if string.sub(arg, 1, 1) == "-" then
        local options_string = string.sub(arg, 2)
	local short_options = splitIntoChars(options_string)
	for _, short_option in ipairs(short_options) do
	    table.insert(options, short_option)
	end
    end
end

if option.find("a") == nil then -- --all
end

local dir = shell.dir()
list(dir)
