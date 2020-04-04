local _={}

_.entity_name=Pow.currentFile()

local build_animation=function()
	-- define animation entity?
	local result={}
	
	local frames_walk={}
	result.walk=frames_walk
	
	local frame1={}
	frame1.sprite_name="pantera_walk_1"
	frame1.duration=30
	
	local frame2={}
	frame2.sprite_name="pantera_walk_2"
	frame2.duration=30
	
	
	table.insert(frames_walk,frame1)
	table.insert(frames_walk,frame2)
	
	return result
end


_.new=function()
	local result=BaseEntity.new(_.entity_name)
	
	result.sprite="pantera"
	
	BaseEntity.init_bounds_from_sprite(result)
	
	result.footX=15
	result.footY=11
	
	result.mountX=12
	result.mountY=5
	result.move_speed=30
	
	result.animation=build_animation()
	
	return result
end


_.updateAi=function(entity)
	AiService.moveRandom(entity)
end

_.interact=Mountable.toggle_mount


return _