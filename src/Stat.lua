local Super = require(script.Parent.Object)
local Stat = Super:Extend()

Stat.BaseValue = 10
Stat.Bonus = 0
Stat.BonusPercent = 0
Stat.BonusFlat = 0

function Stat:Get()
	return (self.BaseValue + self.Bonus) * (1 + self.BonusPercent) + self.BonusFlat
end

return Stat