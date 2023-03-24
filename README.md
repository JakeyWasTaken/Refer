# Refer is no longer updated nor patched for any bugs.

# Refer
Light weight useful scripting framework with built in installer

## Installation
**THIS README MIGHT BE OUT OF DATE, BE SURE TO DOUBLE CHECK EDITS YOU MAKE**<br>

**Method 1:**<br>
Copy installer code [here](https://raw.githubusercontent.com/JakeyWasTaken/Refer/main/Installer.lua)<br>
Paste into roblox studio command line and run<br>
Should be downloaded within 5-6 seconds (Varys depending on internet speed)<br>

**Method 2:** (Recommended)<br>
Install the Refer IAP plugin [here](https://www.roblox.com/library/11240458509/ReferIAP)<br>
Open the plugin<br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*If you wish to change the install location you can do so by doing this: (Default location is ReplicatedStorage)*<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select the new install location<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Then press the "Change Refer Install Location" button (you should see text update above the button)<br>

Now to install press the "Install Refer" button and copy the code out of the text box next to the button<br>
Paste into the command line and run<br>
Should be downloaded within 5-6 seconds (Varys depending on internet speed)<br>

## Documentation
Refer can be used on the client or the server.<br>

**To import a util**<br>
You first need to require Refer

```lua
local Refer = require(script.Parent:WaitForChild("Refer"))
```


Then you can call ```Refer.Import(UtilName)```, now be sure you have put the utils in the "Utils" folder <br>
![image](https://user-images.githubusercontent.com/75340712/195959999-0d8ecd92-3106-4504-b431-a5b7f299f0be.png)
```lua
local Refer = require(script.Parent:WaitForChild("Refer"))

local MyUtil = Refer.Import("MyUtil")
```


Refer also has service capability, you can put the services in either *SharedServices* or *Services* you can use ```Refer.GetService(ServiceName)``` to index them<br>
(Possible unexpected behaviour, the client only reads from the SharedServices folder, the server can read from both)
```lua
local Refer = require(script.Parent:WaitForChild("Refer"))

local MyUtil = Refer.Import("MyUtil")
local MyService = Refer.GetService("MySharedService") -- Client implementation
local MyService = Refer.GetService("MySharedService",true) -- Server implementation
```



***A main characteristic of Refer is that it loads all utils and services at runtime, this means no matter how many times you import them it only ever loads them once, this could be unexpected behaviour for some codebases!***<br>

Refer also puts itself in global variables this means that if needed utils can index other utils using Refer via ```_G.Refer.Import(UtilName)```,<br>
however use of _G isn't recommended therefore you should try avoid this by passing Refer into the util.<br>
```lua
local MyUtil = {}
MyUtil.__index = MyUtil

	function MyUtil.new(Refer)
		local self = setmetatable({},MyUtil)
		
		self.Refer = Refer
		self.TheBestUtil = Refer.Import("TheBestUtil")
		
		return self
	end

return MyUtil
```


## Overview
Refer comes packaged with 6 utils by default:<br>
**Maid**<br>
**MathPlus**<br>
**Raycast**<br>
**Signal**<br>
**Spring**<br>
**Stack**<br>

All respective credits are in each script at line 1<br>

Refer will notify you if it thinks it is out of date, to remove this you need to open the main Refer module and delete these:<br>
```lua
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
```
```lua
VersionCheck()
```

Lines: (This might be out of date so be sure to check)<br>
13,<br>
58<br>

## Thanks for using Refer!
If you run into any issues or feel like a native script should be added feel free to fork or request.
