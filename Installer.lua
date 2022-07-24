local RawUrl = "github.com/JakeyWasTaken/Refer/tree/main/src"
local InstallLocation = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

HttpService.HttpEnabled = true;

if InstallLocation:FindFirstChild("Refer") then
    InstallLocation:FindFirstChild("Refer").Name = "Old_Refer"
end

local corrections = {
	["&quot;"] = '"', ["&amp;"] = "&", ["&#39;"] = "'", ["&lt;"] = "<", ["&gt;"] = ">",
	["Ã¢â€šÂ¬"] = "€", ["Ã‚Â"] = "", ["Ã¢â‚¬Å¡"] = "‚", ["Ã†â€™"] = "ƒ",
	["Ã¢â‚¬Å¾"] = "„", ["Ã¢â‚¬Â¦"] = "…", ["Ã¢â‚¬Â "] = "†", ["Ã¢â‚¬Â¡"] = "‡",
	["Ã‹â€ "] = "ˆ", ["Ã¢â‚¬Â°"] = "‰", ["Ã…Â "] = "Š", ["Ã¢â‚¬Â¹"] = "‹",
	["Ã…â€™"] = "Œ", ["Ã‚Â"] = "", ["Ã…Â½"] = "Ž", ["Ã‚Â"] = "",
	["Ã‚Â"] = "", ["Ã¢â‚¬Ëœ"] = "‘", ["Ã¢â‚¬â„¢"] = "’", ["Ã¢â‚¬Å“"] = "“",
	["Ã¢â‚¬Â"] = "”", ["Ã¢â‚¬Â¢"] = "•", ["Ã¢â‚¬â€œ"] = "–", ["Ã¢â‚¬â€"] = "—",
	["Ã‹Å“"] = "˜", ["Ã¢â€žÂ¢"] = "™", ["Ã…Â¡"] = "š", ["Ã¢â‚¬Âº"] = "›",
	["Ã…â€œ"] = "œ", ["Ã‚Â"] = "", ["Ã…Â¾"] = "ž", ["Ã…Â¸"] = "Ÿ",
	["Ã‚Â "] = " ", ["Ã‚Â¡"] = "¡", ["Ã‚Â¢"] = "¢", ["Ã‚Â£"] = "£",
	["Ã‚Â¤"] = "¤", ["Ã‚Â¥"] = "¥", ["Ã‚Â¦"] = "¦", ["Ã‚Â§"] = "§",
	["Ã‚Â¨"] = "¨", ["Ã‚Â©"] = "©", ["Ã‚Âª"] = "ª", ["Ã‚Â«"] = "«",
	["Ã‚Â¬"] = "¬", ["Ã‚Â­"] = "­", ["Ã‚Â®"] = "®", ["Ã‚Â¯"] = "¯",
	["Ã‚Â°"] = "°", ["Ã‚Â±"] = "±", ["Ã‚Â²"] = "²", ["Ã‚Â³"] = "³",
	["Ã‚Â´"] = "´", ["Ã‚Âµ"] = "µ", ["Ã‚Â¶"] = "¶", ["Ã‚Â·"] = "·",
	["Ã‚Â¸"] = "¸", ["Ã‚Â¹"] = "¹", ["Ã‚Âº"] = "º", ["Ã‚Â»"] = "»",
	["Ã‚Â¼"] = "¼", ["Ã‚Â½"] = "½", ["Ã‚Â¾"] = "¾", ["Ã‚Â¿"] = "¿",
	["Ãƒâ‚¬"] = "À", ["ÃƒÂ"] = "Á", ["Ãƒâ€š"] = "Â", ["ÃƒÆ’"] = "Ã",
	["Ãƒâ€ž"] = "Ä", ["Ãƒâ€¦"] = "Å", ["Ãƒâ€ "] = "Æ", ["Ãƒâ€¡"] = "Ç",
	["ÃƒË†"] = "È", ["Ãƒâ€°"] = "É", ["ÃƒÅ "] = "Ê", ["Ãƒâ€¹"] = "Ë",
	["ÃƒÅ’"] = "Ì", ["ÃƒÂ"] = "Í", ["ÃƒÅ½"] = "Î", ["ÃƒÂ"] = "Ï",
	["ÃƒÂ"] = "Ð", ["Ãƒâ€˜"] = "Ñ", ["Ãƒâ€™"] = "Ò", ["Ãƒâ€œ"] = "Ó",
	["Ãƒâ€"] = "Ô", ["Ãƒâ€¢"] = "Õ", ["Ãƒâ€“"] = "Ö", ["Ãƒâ€”"] = "×",
	["ÃƒËœ"] = "Ø", ["Ãƒâ„¢"] = "Ù", ["ÃƒÅ¡"] = "Ú", ["Ãƒâ€º"] = "Û",
	["ÃƒÅ“"] = "Ü", ["ÃƒÂ"] = "Ý", ["ÃƒÅ¾"] = "Þ", ["ÃƒÅ¸"] = "ß",
	["ÃƒÂ "] = "à", ["ÃƒÂ¡"] = "á", ["ÃƒÂ¢"] = "â", ["ÃƒÂ£"] = "ã",
	["ÃƒÂ¤"] = "ä", ["ÃƒÂ¥"] = "å", ["ÃƒÂ¦"] = "æ", ["ÃƒÂ§"] = "ç",
	["ÃƒÂ¨"] = "è", ["ÃƒÂ©"] = "é", ["ÃƒÂª"] = "ê", ["ÃƒÂ«"] = "ë",
	["ÃƒÂ¬"] = "ì", ["ÃƒÂ­"] = "í", ["ÃƒÂ®"] = "î", ["ÃƒÂ¯"] = "ï",
	["ÃƒÂ°"] = "ð", ["ÃƒÂ±"] = "ñ", ["ÃƒÂ²"] = "ò", ["ÃƒÂ³"] = "ó",
	["ÃƒÂ´"] = "ô", ["ÃƒÂµ"] = "õ", ["ÃƒÂ¶"] = "ö", ["ÃƒÂ·"] = "÷",
	["ÃƒÂ¸"] = "ø", ["ÃƒÂ¹"] = "ù", ["ÃƒÂº"] = "ú", ["ÃƒÂ»"] = "û",
	["ÃƒÂ¼"] = "ü", ["ÃƒÂ½"] = "ý", ["ÃƒÂ¾"] = "þ", ["ÃƒÂ¿"] = "ÿ",
}

local function getScriptFromHtml(script)
    local lines = script and type(script) == "string" and script:split("        <tr>\n")
    if lines then
        table.remove(lines, 1)
        local codeLines = {}
        
        for _, line in ipairs(lines) do
            local lineOfCode = line:split("\n")[2]
            local currentLine = ""

            if lineOfCode then
                for code, _ in lineOfCode:gmatch(">(.-)<") do
                    for find, replace in pairs(corrections) do
                        code = code:gsub(find, replace)
                    end

                    currentLine = currentLine .. code
                end
            end
            table.insert(codeLines, currentLine)
        end

        return table.concat(codeLines, "\n")
    end
end

local function GetAsync(url)
    url = "https://"..url

    local rt
    local s,e = pcall(function()
        rt = HttpService:GetAsync(url)
    end)

    if s then
        return getScriptFromHtml(rt)
    else
        warn(e)
        warn(url)
    end
end

local function Import(obj,objName,parent,path)
    task.wait(0.05) -- slow down rate of download

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

        path = RawUrl..path
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
    if k ~= "Version" then
        Import(v,k,InstallLocation,"")
    end
end

warn(("Install complete, time taken: %s."):format(tick()-start))