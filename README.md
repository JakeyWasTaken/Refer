# Refer
Light weight useful scripting framework with built in installer

## Installation
**THIS README MIGHT BE OUT OF DATE, BE SURE TO DOUBLE EDITS YOU MAKE**<br>

**Method 1:**<br>
Copy installer code [here](Refer/Installer.lua)<br>
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

![image](https://user-images.githubusercontent.com/75340712/195960826-852a2aa3-ea83-4b32-8565-2b064e251cfa.png)<br>


Then you can call ```Refer.Import(UtilName)```, now be sure you have put the utils in the "Utils" folder <br>
![image](https://user-images.githubusercontent.com/75340712/195959999-0d8ecd92-3106-4504-b431-a5b7f299f0be.png)
![image](https://user-images.githubusercontent.com/75340712/195960376-76d1d5a7-bebb-4df9-b803-25f4eee92682.png)


Refer also has service capability, you can put the services in either *SharedServices* or *Services* you can use ```Refer.GetService(ServiceName)``` to index them<br>
(Possible unexpected behaviour, the client only reads from the SharedServices folder, the server can read from both)
![image](https://user-images.githubusercontent.com/75340712/195960384-de976655-70af-46e2-b97f-6f5f0b8f1f7d.png)



***A main characteristic of Refer is that it loads all utils and services at runtime, this means no matter how many times you import them it only ever loads them once, this could be unexpected behaviour for some codebases!***<br>

Refer also puts itself in global variables this means that if needed utils can index other utils using Refer via ```_G.Refer.Import(UtilName)```,<br>
however use of _G isn't recommended therefore you should try avoid this by passing Refer into the util.<br>
![image](https://user-images.githubusercontent.com/75340712/195960499-4c50d8d8-a836-4bda-b84c-31081d22af0b.png)


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
![image](https://user-images.githubusercontent.com/75340712/195960609-29b7e917-7d13-45ba-8e71-ac464fde8f96.png)<br>
![image](https://user-images.githubusercontent.com/75340712/195960616-623d064a-30f3-430a-84cf-43aa62ad2116.png)<br>

Lines: (This might be out of date so be sure to check)<br>
13,<br>
58<br>

## Thanks for using Refer!
If you run into any issues or feel like a native script should be added feel free to fork or request.
