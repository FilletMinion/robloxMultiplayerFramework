local SessionData = {}

SessionData.Players = {}

function SessionData:AddPlayer(name, PlayerObj)
	--print(name, ' is adding ', PlayerObj, ' to the table')
	self.Players[name] = PlayerObj
end

function SessionData:GetPlayer(name)
	--print('getting ', name, ' from Player table')
	return self.Players[name]
end

function SessionData:GetPlayerWeapon(name)
	return self.Players[name].weapon.name
end

function SessionData:GetPlayers()
	return self.Players
end
