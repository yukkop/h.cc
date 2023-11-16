-- Function to print the current working directory
local function printWorkingDirectory()
    local currentDir = shell.dir()
    print(currentDir)
end

printWorkingDirectory()
