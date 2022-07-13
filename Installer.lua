local RawUrl = "https://raw.githubusercontent.com/JakeyWasTaken/Refer/main/src/"
local InstallLocation = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

HttpService.HttpEnabled = true;

local DataTree = HttpService:GetAsync(RawUrl.."datatree.json")
DataTree = HttpService:JSONDecode(DataTree)

warn("Downloaded data tree, starting installation.")

local function GetAsync(url)
    local rt
    local s,e = pcall(function()
        rt = HttpService:GetAsync(url)
    end)

    if s then
        return rt
    else
        warn(e)
        warn(url)
    end
end

local function Import(obj,objName,parent,path)
    warn(("Importing %s of type %s into %s, path: %s"):format(objName,obj.Type,parent.Name,RawUrl..path))

    if obj.Type == "Folder" then
        local Folder = Instance.new("Folder")
        Folder.Name = objName

        Folder.Parent = parent

        if #obj.Children > 0 then
            for k,v in pairs(obj.Children) do
                Import(v,k,Folder,path.."/"..objName)
            end
        end

        return true
    end

    if obj.Type == "ModuleScript" then
        local ModuleScript = Instance.new("ModuleScript")
        ModuleScript.Name = objName
        ModuleScript.Parent = parent

        ModuleScript.Source = GetAsync(RawUrl..path)

        if #obj.Children > 0 then
            for k,v in pairs(obj.Children) do
                Import(v,k,ModuleScript,path.."/"..objName)
            end
        end

        return true
    end
end

local start = tick()

for k,v in pairs(DataTree) do
    Import(v,k,InstallLocation,"")
end

warn(("Install complete, time taken: %s."):format(tick()-start))