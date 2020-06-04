local _={}

_.entity_name=Pow.currentFile()

_.new=function()
	local result=BaseEntity.new(_.entity_name)
	
	result.sprite=_.entity_name
	result.is_item=true
	result.origin_x=4
	result.origin_y=1
	
	BaseEntity.init_bounds_from_sprite(result)
	
	return result
end

return _