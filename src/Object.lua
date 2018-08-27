local Object = {}

Object.Storage = game:GetService("ReplicatedStorage")

function Object:Extend(object)
	object = object or {}
	setmetatable(object, self)
	self.__index = self
	return object
end

-- call create to make an instance of a class
-- it will fire an OnCreated event, if it has one
function Object:Create(object)
	object = self:Extend(object)
	if object.OnCreated then
		object:OnCreated()
	end
end

-- returns whether or not a class in an instance
-- of this class or any class that inherits from it
function Object:IsA(arg1)
	-- disambiguate the arguments
	local class
	if typeof(arg1) == "table" then
		class = arg1

	elseif typeof(arg1) == "string" then
		class = self:GetClass(arg1)
	end

	-- run the test
	local myClass = self
	while myClass do
		myClass = getmetatable(myClass)
		if myClass == class then
			return true
		end
	end
	return false
end

-- returns the class with the given name
function Object:GetClass(className)
	local function search(folder)
		for _, child in pairs(folder:GetChildren()) do
			if child:IsA("ModuleScript") and child.Name == className then
				return require(child)

			elseif child:IsA("Folder") then
				local moduleScript = search(child)
				if moduleScript then
					return require(moduleScript)
				end
			end
		end
	end
	return search(script.Parent)
end

-- returns a function which will create an object of
-- the given class name
-- ex: self:CreateNew"Object"{Attribute = Value}
function Object:CreateNew(className)
	return function(args)
		self:GetClass(className):Create(args)
	end
end

-- returns the world of this environment
-- each client has a world, and the server
-- has a world
function Object:GetWorld()
	return self:GetClass"World"
end

-----------------------------------------------------------------------------------------------------------
-- the following section is dedicated to some nice little functions that all objects will have access to --
-----------------------------------------------------------------------------------------------------------

-- some math utilities that are missing from
-- the regular roblox codebase
Object.Math = {}

function Object.Math.Lerp(a, b, w)
	return a + (b - a) * w
end

-- some randomization utilities that I find
-- helpful to have around
Object.Random = {}

function Object.Random.Choose(list)
	return list[math.random(1, #list)]
end

function Object.Random.RandomSign()
	return Object.Random.Choose{-1, 1}
end

function Object.Random.Shuffle(list)
	local length = #list
	for indexA = 1, length do
		local indexB = math.random(1, length)
		local valueA = list[indexA]
		list[indexA] = list[indexB]
		list[indexB] = valueA
	end
end

function Object.Random.Random(a, b)
	return Object.Math.Lerp(a, b, math.random())
end

function Object.Random.Chance(chance, chanceMax)
	if not chanceMax then
		chanceMax = 100
	end

	local float = chance / chanceMax
	return math.random() <= float
end

-- some table utilities that are very nice to
-- have access to in your codebase
Object.Table = {}

function Object.Table.Contains(list, value)
	for _, v in pairs(list) do
		if v == value then
			return true
		end
	end
	return false
end

return Object