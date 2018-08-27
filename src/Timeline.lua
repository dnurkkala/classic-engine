local Super = require(script.Parent.WorldObject)
local Timeline = Super:Extend()

Timeline.Interval = 0
Timeline.Infinite = false
Timeline.Time = 1

function Timeline:OnCreated()
	self.MaxTime = self.Time
	self.DeltaTime = 0
end

function Timeline:OnUpdated(dt)
	self.DeltaTime = self.DeltaTime + dt
	if self.DeltaTime >= self.Interval then
		self:OnTicked(self.DeltaTime)
		self.DeltaTime = 0
	end

	if not self.Infinite then
		self.Time = self.Time - dt
		if self.Time <= 0 then
			self.Active = false
		end
	end
end

function Timeline:GetProgress()
	return 1 - (self.Time / self.MaxTime)
end

function Timeline:Reset()
	self.Time = self.MaxTime
end

function Timeline:OnDestroyed()
	self:OnEnded()
end

function Timeline:Start()
	self:OnStarted()
	self:GetWorld():AddObject(self)
end

function Timeline:Stop()
	self.Time = 0
	self.Active = false
end

function Timeline:OnStarted()
	-- placeholder
	-- the timeline just started
end

function Timeline:OnTicked(dt)
	-- placeholder
	-- the timeline was just ticked on its interval
end

function Timeline:OnEnded()
	-- placeholder
	-- the timeline just finished and is no longer active
end

return Timeline