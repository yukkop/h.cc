-- Function to run a console command
local function runCommand(command)
    local success, message = shell.run(command)
    if not success then
        print("Command failed: " .. (message or "Unknown error"))
    end
end

if not fs.exists("/.bin/") then
    runCommand("mkdir /.bin/");
end

if fs.exists("/.bin/dg.lua") then
    runCommand("rm /.bin/dg.lua");
end

local url = "https://raw.githubusercontent.com/yukkop/h.cc/master/startup/dg.lua"
local response = http.get(url)

if response then
    local content = response.readAll()
    local file = fs.open("/.bin/dg.lua", "w")
    file.write(content)
    file.close()
    print("File dg.lua downloaded successfully")
else
    print("Failed to download file dg.lua.")
end


runCommand("cd /.bin/");
runCommand("dg yukkop/h.cc startup/bins /bins");

-- Reading each line of a file in Lua (ComputerCraft)
local file = fs.open("/bins", "r") 
if file then
    while true do
        local line = file.readLine()
        if line == nil then break end  -- Exit the loop when end of file is reached
	
        if fs.exists("/.bin/" .. line) then
            runCommand("rm /.bin/" .. line);
	end
	runCommand("dg yukkop/h.cc startup/" .. line .. " /.bin/" .. line);
    end
    file.close()
else
    print("File not found")
end

runCommand("rm /bins");

runCommand("rm /startup.lua");
runCommand("dg yukkop/h.cc startup/startup.lua /startup.lua");

runCommand("reboot");
