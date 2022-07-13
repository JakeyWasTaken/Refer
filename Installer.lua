local RawUrl = "raw.githubusercontent.com/JakeyWasTaken/Refer/main/src/"
local InstallLocation = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

HttpService.HttpEnabled = true;

local function GetAsync(url)
    url = "https://"..url

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

        local pathSplit = string.split(path,"/")
        local newPath = ""

        for _,p in ipairs(pathSplit) do
            if p == "Refer" then
                continue
            end

            newPath = newPath..p.."/"
        end

        newPath = string.sub(newPath,1,#newPath-1)
        

        if #obj.Children > 0 then
            for k,v in pairs(obj.Children) do
                Import(v,k,Folder,newPath.."/"..objName)
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

local DataTree = GetAsync(string.sub(RawUrl,1,#RawUrl-4).."datatree.json")
DataTree = HttpService:JSONDecode(DataTree)

warn("Downloaded data tree, starting installation.")

for k,v in pairs(DataTree) do
    Import(v,k,InstallLocation,k)
end

warn(("Install complete, time taken: %s."):format(tick()-start))