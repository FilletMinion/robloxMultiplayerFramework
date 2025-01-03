local UIS = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local RS = game:GetService('ReplicatedStorage')
local Player = game.Players.LocalPlayer
local Character = nil
local HRP = nil
local Humanoid = nil
local Mouse = Player:GetMouse()
local Camera = workspace.Camera
local Weapon = nil --module script for weapon
local Special = nil -- module script for ability 
local confirmKey = nil 
local maxCameraHeight = 30
local minCameraHeight = 15
local cameraHeight = maxCameraHeight
----------------------------------------------------input control variables
local Xdist = 0
local Ydist = 0
local lookAngle = 0
local shootControl = {AS = nil, canShoot = true, shooting = false}
local QControl = {QCD = nil, canQ = true, Qing = false}
local ECD = nil
local canE = true
local RCD = nil
local canR = true
local FCD = nil
local canF = true
local channeling = false


Mouse.Icon = 'rbxasset://textures/GunCursor.png'
-------------------------------------------------------------------Events
local giveToController = RS.Events.giveToController
local sendToSD = giveToController.sendToSD
local MB1Down = RS.Events.Mouse1Down
local MB1Up = RS.Events.Mouse1Up

-------------------------------------------------------------------------------------------CAMERA HANDLERS ANS INITS----------------------------------------------------------
Player.CharacterAdded:Connect(function()
		Character = Player.Character
		HRP = Character:WaitForChild('HumanoidRootPart')
		Humanoid = Character:WaitForChild('Humanoid')
		Humanoid.AutoRotate = false
		Camera.CameraType = Enum.CameraType.Scriptable
end)

local function onWheelBackward()
	if cameraHeight < maxCameraHeight then
		cameraHeight += 1
	end
end

local function onWheelForward ()
	if cameraHeight > minCameraHeight then
		cameraHeight -= 1
	end
end

local function cameraTrack () --controls camera position relative to player
	if HRP == nil then
		return
	end

	local origin = HRP.Position --+ Vector3.new(0, 0.5, 0)
	local mouseDist = math.sqrt((Xdist^2) + (Ydist^2))/80--determines camera drift from center
	local Xoffset = math.cos(lookAngle) * mouseDist * (cameraHeight/16)
	local Yoffset = math.sin(lookAngle) * mouseDist * (cameraHeight/16)
	local cameraPosition = origin + Vector3.new(-(cameraHeight * 0.25)+Xoffset, cameraHeight, -Yoffset)
	local lookAt = origin + Vector3.new(Xoffset , 0 , -Yoffset)
	Camera.CFrame = CFrame.new(cameraPosition, lookAt)
end

local function onInputChanged(inputObject) -- changes the look direction of character
	if HRP == nil then
		return
	end
		
	if inputObject.UserInputType == Enum.UserInputType.MouseMovement then
		local mousePosition = inputObject.Position
		local screenCenter = Vector2.new(Mouse.ViewSizeX / 2, Mouse.ViewSizeY / 2) 
		Xdist = screenCenter.X - mousePosition.X
		Ydist = screenCenter.Y - mousePosition.Y
		--print('x: ', Xdist, 'y: ', Ydist)
		lookAngle = math.atan2(Xdist, Ydist)
		HRP.CFrame = CFrame.new(HRP.Position) * CFrame.Angles(0, lookAngle - (0.5 * math.pi),0)
	end
end

Mouse.WheelForward:Connect(onWheelForward)
Mouse.WheelBackward:Connect(onWheelBackward)
RunService.RenderStepped:Connect(cameraTrack)
UIS.InputChanged:Connect(onInputChanged)

giveToController.OnClientEvent:Connect(function(weaponName)
	sendToSD:FireServer(confirmKey)
	confirmKey = math.random(0,999999)
	print('creating confirm key: ', confirmKey)
	Weapon = require(RS.Scripts.Weapon:WaitForChild(weaponName))
	AS = Weapon.baseAS
end)

--------------------------------------------------------------------------------------------------------------------COMBAT INPUTS-----------------------------------------------------------------
local function shooting (toggle)
	while toggle == true do
		if canShoot == true then
			Weapon.shoot()
		end
		
		canShoot = false
		task.wait(1/AS)
		canShoot = true
	end
end


Mouse.Button1Down:Connect(function()
	shooting(true)
end)

Mouse.Button1Up:Connect(function()
	shooting(false)
	--print(Player, ' just fired ', self.weapon)
end)

------------------------------------------------------------------------------------------------------------------------Defining module here------------------------------------------------
local InputController = {}

return InputController
