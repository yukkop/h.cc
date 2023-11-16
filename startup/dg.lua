
-- Function to display help information
local function displayHelp(priogramname)
    print(programName .. " <repo> <fileName> <savePath> [-b]")
    print(" -h/--help    show this message")
end

-- Function to download a file from GitHub
local function downloadFromGitHub(repo, filePath, savePath, branch)
    local url = "https://raw.githubusercontent.com/" .. repo .. "/" .. (branch or "master") .. "/" .. filePath
    local response = http.get(url)

    if response then
        local content = response.readAll()
	local file = fs.open(savePath, "w")
	file.write(content)
	file.close()
        print("File downloaded successfully: " .. savePath)
    else
        print("Failed to download file.")
    end
end

-- Main
local priogramname = arg[0] or "script"
local args = {...}
local branch


-- TODO improve args system becouse it is suck
-- Check for help argument
if #args < 3 or args[1] == "--help" or args[1] == "-h"
    displayHelp(priogramname)
    return
end

-- Parse arguments
local repo = args[1]
local filePath = args[2]
local savePath = args[3]

for i = 4, #args do
    if args[i] == "-b" and args[i + 1] then
        branch = args[i + 1]
	break
    end
end

downloadFromGitHub(repo, filePath, savePath, branch)
