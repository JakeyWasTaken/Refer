local HttpService = game:GetService("HttpService")
local Utils = script:WaitForChild("Utils")

local VersionSettings = require(Utils:WaitForChild("VersionSettings"))

local function VersionCheck()
    local DataTree = HttpService:GetAsync("https://raw.githubusercontent.com/JakeyWasTaken/Refer/main/datatree.json")
    DataTree = HttpService:JSONDecode(DataTree)

    if DataTree.Version ~= VersionSettings.Version then
        warn(("Refer is not at the latest version, consider updating to version %s (Current version: %s)"):format(DataTree.Version,VersionSettings.Version))
    end
end

VersionCheck()

