local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local Utils = script:WaitForChild("Utils")
local Private = script:WaitForChild("Private")
local Services = (if RunService:IsServer() then script:WaitForChild("Services") else nil)
local SharedServices = script:WaitForChild("SharedServices")

local VersionSettings = require(Private:WaitForChild("VersionSettings"))
local UtilCache = {}
local ServiceCache = {}
local SharedServiceCache = {}

local function VersionCheck()
    if RunService:IsClient() then -- Prevent client running version check
        return
    end

    local DataTree = HttpService:GetAsync("https://raw.githubusercontent.com/JakeyWasTaken/Refer/main/datatree.json")
    DataTree = HttpService:JSONDecode(DataTree)

    if DataTree.Version ~= VersionSettings.Version then
        warn(("Refer is not at the latest version, consider updating to version %s (Current version: %s)"):format(DataTree.Version,VersionSettings.Version))
    end
end

local function CacheUtils()
    for _,Util in ipairs(Utils:GetChildren()) do
        UtilCache[Util.Name] = require(Util)
    end
end

local function CacheServices()

    for _,Service in ipairs(SharedServices:GetChildren()) do
        SharedServiceCache[Service.Name] = require(Service)
    end

    if RunService:IsClient() then
        return
    end

    for _,Service in ipairs(Services:GetChildren()) do
        ServiceCache[Service.Name] = require(Service)
    end

    Services.Parent = game:GetService("ServerStorage")
end



local Refer = {
    ["Utils"] = UtilCache,
    ["Services"] = ServiceCache,
    ["SharedServices"] = SharedServiceCache
}
_G.Refer = Refer

VersionCheck()
CacheUtils()
CacheServices()

    Refer.Import = function(Name : string) : table
        assert(UtilCache[Name],("[Refer] Cannot find util of name %s"):format(Name))

        return UtilCache[Name]
    end

    Refer.GetService = function(Name : string , UsedShared : boolean?) : table
        if UsedShared or RunService:IsClient() then
            assert(SharedServiceCache[Name],("[Refer] Cannot find service of name %s"):format(Name))

            return SharedServiceCache[Name]
        elseif RunService:IsServer() then
            assert(ServiceCache[Name],("[Refer] Cannot find service of name %s"):format(Name))

            return ServiceCache[Name]
        end
    end

return Refer