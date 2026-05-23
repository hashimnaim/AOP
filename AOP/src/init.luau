--!strict
--author: @hashim.naim
--date: 5/23/26
type AOP = {
	__index: AOP,
	avaliable: { Instance },
	create: (self: AOP, obj: Instance) -> AOP,
	addObj: (self: AOP, obj: Instance) -> (),
	getObj: (self: AOP, obj: Instance) -> (),
	clearObjs: (self: AOP) -> (),
	returnObj: (self: AOP, obj: Instance) -> (),
}

local AOP = {}
AOP.__index = AOP

-- Creates a new AOP object
function AOP.create(obj: Instance): AOP
	local self = {
		avaliable = {},
	}
	setmetatable(self, AOP)

	return self
end

function AOP:addObj(obj: Instance)
	return table.insert(self.avaliable, obj)
end

-- Grabs object from table.
function AOP:getObj(obj: Instance)
	return table.find(self.avaliable, obj)
end

-- Returns object to table.
function AOP:returnObj(obj: Instance)
	return table.insert(self.avaliable, obj)
end

-- Clears Objs from table.
function AOP:clearObjs()
	for _, obj in self.avaliable do
		if obj then
			self.avaliable[obj] = nil
			obj:Destroy()
		else
			return warn(`>>> AOP Module could not find: {obj}`)
		end
	end
	table.clear(self.avaliable)

	return warn(`>>> AOP Module cleared avaliable objs`)
end

return AOP
