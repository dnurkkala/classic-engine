local Super = require(script.Parent.HumanoidCharacter)
local PlayerCharacter = Super:Extend()

function PlayerCharacter:OnCreated()
	assert(self.Player)

	self.Model = self.Player.Character

	Super.OnCreated(self)
end

return PlayerCharacter