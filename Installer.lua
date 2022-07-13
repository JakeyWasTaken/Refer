local RawUrl = "raw.githubusercontent.com/JakeyWasTaken/Refer/main/src"
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
    if obj.Type == "Folder" then
        local Folder = Instance.new("Folder")
        Folder.Name = objName

        Folder.Parent = parent

        local pathSplit = string.split(path,"/")
        local newPath = ""

        for _,p in ipairs(pathSplit) do
            if p == "Refer.lua" or p == "" then
                continue
            end

            newPath = newPath..p.."/"
        end
        
        if string.sub(newPath,#newPath,#newPath) ~= "/" then
            newPath = newPath.."/"..objName
        else
            newPath = newPath..objName
        end
        
        path = newPath
        
        for k,v in pairs(obj.Children) do
            Import(v,k,Folder,path)
        end
    end

    if obj.Type == "ModuleScript" then
        local ModuleScript = Instance.new("ModuleScript")
        ModuleScript.Name = objName
        ModuleScript.Parent = parent

        path = path.."/"..objName..".lua"

        ModuleScript.Source = GetAsync(RawUrl..path)

        for k,v in pairs(obj.Children) do
            Import(v,k,ModuleScript,path)
        end

        path = RawUrl..path
    end

    print(("Imported %s of type %s into %s, path: %s"):format(objName,obj.Type,parent.Name,path))
end

local start = tick()

local DataTree = GetAsync(string.sub(RawUrl,1,#RawUrl-3).."/datatree.json")
DataTree = HttpService:JSONDecode(DataTree)

warn("Downloaded data tree, starting installation.")

for k,v in pairs(DataTree) do
    Import(v,k,InstallLocation,"")
end

warn(("Install complete, time taken: %s."):format(tick()-start))