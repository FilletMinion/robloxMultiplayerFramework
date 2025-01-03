local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SSS = game:GetService('ServerScriptService')
local Player = require(RS.Scripts.Player)
local SessionData = require(SSS.Session.SessionData)
local Events = RS.Events
local Weapons = RS.Weapons
local Specials = RS.SpecialWeapons
local giveToController = RS.Events.giveToController
local sendToSD = giveToController.sendToSD

local Mouse1Down = RS.Events.Mouse1Down
local Mouse1Up = RS.Events.Mouse1Up

local function sendToController (player)
	--task.wait(1)
	local weaponName = SessionData:GetPlayerWeapon(player.Name)
	 giveToController:FireClient(player, weaponName)
	 print('controller has weapon now')
end

local function establishKey(player, newKey)
	local playerName = player.Name
	if SessionData.Players[playerName].confirmKey == -1 then
		SessionData.Players[playerName].confirmKey = newKey
	end
	--print('new key is now ',SessionData:GetPlayer(playerName))
end

local function onPlayerAdded(player) --initialize weapon on spawn
	local WeaponClass = require(RS.Scripts.Weapon.Glicky)
	local newWeaponStruct = WeaponClass.new() --creates data model for weapon
	
	local newPlayerObject = Player.new(player, newWeaponStruct, 'Heal')
	SessionData:AddPlayer(player.Name, newPlayerObject)
	--sendToController(player)
	sendToController(player)
	player.CharacterAdded:Connect(function(character)
	newWeaponStruct:Equip(character)
		print('packed')
	end)
end

sendToSD.OnServerEvent:Connect(establishKey)


-- Connect the PlayerAdded event
Players.PlayerAdded:Connect(onPlayerAdded)
