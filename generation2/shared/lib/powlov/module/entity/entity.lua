-- entity manager. single instance.

local _={}


-- _.update=
local _drawable={}
local _updatable={}
local _lateUpdatable={}
local _uiDraws={}

--добавить сущность в менеджер
_.add=function(entity)
	log('adding entity:'..Entity.toString(entity),'entity')
	
	local entityCode=nil
	if entity.isService then
		entityCode=entity
	end
	
	local draw=entityCode.draw
	if draw~=nil then
		_drawable[entity]=draw
	end
	
	local update=entityCode.update
	if update~=nil then
		_updatable[entity]=update
	end
	
	local lateUpdate=entityCode.lateUpdate
	if lateUpdate~=nil then
		_lateUpdatable[entity]=lateUpdate
	end
	
	local drawUi=entityCode.drawUi
	if drawUi~=nil then
		_uiDraws[entity]=drawUi
	end
end

_.remove=function(entity)
	_drawable[entity]=nil
	_updatable[entity]=nil
	_lateUpdatable[entity]=nil
end

_.draw=function()
	for entity,drawProc in pairs(_drawable) do
		drawProc()
	end
end

_.drawUi=function()
	for entity,draw in pairs(_uiDraws) do
		draw()
	end
end

_.update=function(dt)
	for entity,updateProc in pairs(_updatable) do
		updateProc(dt)
	end
end


_.lateUpdate=function(dt)
	for entity,updateProc in pairs(_lateUpdatable) do
		updateProc(dt)
	end	
end



_.toString=function(entity)
	if entity==nil then return "nil" end
	return entity.entityName.." id:"..tostring(entity.id)
end

return _