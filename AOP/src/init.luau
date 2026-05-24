--!strict
--author: @hashim.naim
--date: 5/23/26
type AOPImpl = {
	__index: AOPImpl,
	avaliable: { Instance },
	create: (self: AOPImpl, obj: Instance, avaliable: { Instance }) -> AOPImpl,
	addObj: (self: AOPImpl, obj: Instance, avaliable: { Instance }) -> (),
	getObj: (self: AOPImpl, obj: Instance, avaliable: { Instance }) -> (),
	clearObjs: (self: AOPImpl, obj: Instance) -> (),
	returnObj: (self: AOPImpl, obj: Instance, avaliable: { Instance }) -> (),
}

type AOP = typeof(setmetatable({} :: {object: Instance}, {} :: AOPImpl));

local AOP: AOP = {} :: AOP
AOP.__index = AOP

-- Creates a new AOP object
function AOP.create(obj): AOP
	local self = {
		obj = obj;
		avaliable = {};
	}
	setmetatable(self, AOP)

	return self
end

function AOP:addObj(obj)
	return table.insert(self.avaliable, obj)
end

-- Grabs object from table.
function AOP:getObj(obj)
	return table.find(self.avaliable, obj)
end

-- Returns object to table.
function AOP:returnObj(obj)
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
