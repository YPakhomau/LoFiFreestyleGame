local _={}

_.entity_name=Pow.currentFile()

_.new=function()
	local result=BaseEntity.new(_.entity_name)
	
	result.sprite="firecamp_2"
	
	BaseEntity.init_bounds_from_sprite(result)
	
	return result
end


return _