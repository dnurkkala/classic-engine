local Super = require(script.Parent.Character)
local HumanoidCharacter = Super:Extend()

function HumanoidCharacter:OnCreated()
	Super.OnCreated(self)

	self.Humanoid = self.Model:FindFirstChild("Humanoid")
	assert(self.Humanoid)

	self.Root = self.Model:FindFirstChild("HumanoidRootPart")
	assert(self.Root)
end

function HumanoidCharacter:InitStats()
	Super.InitStats(self)

	self.Speed = self:CreateNew"Stat"{BaseValue = 16}
	self.JumpPower = self:CreateNew"Stat"{BaseValue = 64}
end

function HumanoidCharacter:OnUpdated(dt)
	Super.OnUpdated(self, dt)

	self.Humanoid.MaxHealth = self.MaxHealth:Get()
	self.Humanoid.Health = self.Health
	self.Humanoid.WalkSpeed = self.Speed:Get()
	self.Humanoid.JumpPower = self.JumpPower:Get()
end

return HumanoidCharacter