local Super = require(script.Parent.Object)
local World = Super:Extend()

function World:OnCreated()
	self.Objects = {}

	local function onHeartbeat(dt)
		self:OnUpdated(dt)
	end
	game:GetService("RunService").Heartbeat:Connect(onHeartbeat)
end

function World:OnUpdated(dt)
	for index = #self.Objects, 1, -1 do
		local object = self.Objects[index]
		if object.Active then
			object:OnUpdated(dt)
		end

		-- check on the same frame so that we can destroy
		-- on the same frame we update if the update
		-- deactivates the object
		if not object.Active then
			object:OnDestroyed()
			table.remove(self.Objects, index)
		end
	end
end

function World:AddObject(object)
	table.insert(self.Objects, object)
end

local Singleton = World:Create()
return Singleton