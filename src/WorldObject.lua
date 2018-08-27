local Super = require(script.Parent.Object)
local WorldObject = Super:Extend()

WorldObject.Active = true

function WorldObject:OnUpdated(dt)
	-- placeholder
end

function WorldObject:OnDestroyed()
	-- placeholder
end

return WorldObject