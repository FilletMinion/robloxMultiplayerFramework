local RS = game:GetService('ReplicatedStorage')
local Weapon = RS.Scripts.Weapon

local Player = {}
Player.__index = Player

function Player.new(player, weapon, special) --player object, string for weapon object, string for special object
	local self = {
		--primary variables
		player = player, --player object
		confirmKey = -1,
		weapon = weapon, -- weapon data object
		special = special, -- string for special object
		channeling = false, -- determines if other abilities can be cast or not
		canShoot = true,
		shooting = false,
		dmgDealt = 0,
		--combat stats
		armor = 0,
		AsMult = 1,
		DmgMult = 1,
		HP = 100,
		MaxHP = 100,
		MsMult = 1,
		CritChance = 0,
		CritBonus = 0 --add this to weapon's current crit multiplier
		
	}
	setmetatable(self, Player)
	return self
end

function Player:updateDmgDealt(amount)
	self.dmgDealt = self.dmgDealt + amount
end

--function Player:Fire(lookAngle)  
--	self.weapon:Fire(lookAngle)
--end

function Player:startShooting ()
	if self.shooting ~= true then
		self.shooting = true
	end
	
	if self.canShoot == true then
		if self.canShoot ~= false then -- does not allow the player to input another shoot command
			self.canShoot = false
		end

		while self.shooting == true do
			self.weapon:Fire(self.player)
			task.wait(1/(self.weapon.as * self.AsMult))
		end

		if self.canShoot ~= true then
			self.canShoot = true
		end
	end
	
end

return Player
