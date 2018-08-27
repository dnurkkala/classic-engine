local Super = require(script.Parent.WorldObject)
local Character = Super:Extend()

function Character:OnCreated()
	assert(self.Model)
	assert((self.Root ~= nil) or (self.Model.PrimaryPart ~= nil))

	if self.Root == nil then
		self.Root = self.Model.PrimaryPart
	end

	self:InitStats()
end

function Character:InitStats()
	self.MaxHealth = self:CreateNew"Stat"{BaseValue = 100}
	self.Health = self.MaxHealth:Get()
end

function Character:OnUpdated(dt)
	if self.Health <= 0 then
		self.Active = false
	end
end

function Character:OnDestroyed()
	self.Model:Destroy()
end

function Character:GetCFrame()
	return self.Root.CFrame
end

function Character:GetSquaredDistanceTo(point)
	if typeof(point) == "CFrame" then
		point = point.Position
	end

	local delta = point - self:GetCFrame().Position

	return (delta.X * delta.X) + (delta.Y * delta.Y) + (delta.Z * delta.Z)
end

function Character:GetDistanceTo(point)
	return math.sqrt(self:GetSquaredDistanceTo(point))
end

function Character:IsPointInRange(point, range)
	local squaredRange = range * range
	local squaredDistance = self:GetSquaredDistanceTo(point)
	return squaredDistance <= squaredRange
end

return Character