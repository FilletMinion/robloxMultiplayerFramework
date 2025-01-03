local Weapon = {}
Weapon.__index = Weapon

function Weapon.new(name, dmg, as, critChance, critMult, range) 
	local self = {
		name = name,
		dmg = dmg,
		as = as,
		critChance = critChance,
		critMult = critMult,
		range = range,
	}
	setmetatable(self, Weapon)
	return self
end


function Weapon:rollCrit()
	local randn = math.random()  --run this with every shot. It returns a value for you to multiply your boolet dmg by
	
	if randn <= self.critChance then
		return self.critMult
	elseif randn < self.crit then
		return 1
	end
end

function Weapon:Fire() --ALWAYS have the player call this function
	print(self.name, ' has fired')
end
return Weapon
