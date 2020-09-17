-- todo: make it part of pow
-- цель - коллизии по уровням,
-- следующий уровень абстракции: collision (одноуровневая модель)

local _entity_name='CollisionService'
local _=BaseEntity.new(_entity_name, true)


local _levelCollisions={}

-- returns instance of shared\lib\powlov\module\collision.lua
local getLevelCollisions=function(level_name)
	local result=_levelCollisions[level_name]
	if result==nil then
		log("created collision level:"..level_name, "verbose")
		result=Pow.newCollision()
		_levelCollisions[level_name]=result
	end
	
	return result
end

---- unfinished - we can paint it later
--_.getCollisionShapes=function(level_name)
--	local collisions=getLevelCollisions(level_name)
--	local result={}
	
--	collisions.getShapes()
	
--	return result
--end


-- returns array of entity - who collides with entity shape
_.getEntityCollisions=function(entity)
	local level_name=entity.level_name
	local levelCollisions=getLevelCollisions(level_name)
	local entityCollisions=levelCollisions.getAtEntity(entity)
	return entityCollisions
end

-- get_at_point

_.get_around=function(entity, margin)
	local x=entity.x-margin
	local w=entity.w+margin
	local y=entity.y-margin
	local h=entity.h+margin
	
	local level_name=entity.level_name

	local result=_.get_in_rect(x,y,w,h,level_name)
	-- todo exclude self
	
	return result
end

_.get_in_rect=function(x,y,w,h,level_name)
	-- see shared\lib\powlov\module\collision.lua
	local level_collisions=getLevelCollisions(level_name)
	local result=level_collisions.getAtRect(x,y,w,h)
	return result
end



_.addEntity=function(entity)
	if entity==nil then 
		log("warn: adding null entity") 
		return
	end
	
	if entity.is_service then
		return
	end
	
	
	
	local level_name=entity.level_name
	
	if level_name==nil then
		log('error: adding entity with no level_name to collision system')
		return
	end
	
	local collision=getLevelCollisions(level_name)
	collision.add(entity)
end



_.removeEntity=function(entity)
		local level_name=entity.level_name
	
	if level_name==nil then
		log('error: removing entity with no level_name from collision system')
		return
	end
	
	local collision=getLevelCollisions(level_name)
	collision.remove(entity)
end

_.onEntityMoved=function(entity)
	local level_name=entity.level_name
	
	if level_name==nil then
		log('error: moving entity with no level_name into collision system')
		return
	end
	
	local collision=getLevelCollisions(level_name)
	collision.moved(entity)
end

return _
