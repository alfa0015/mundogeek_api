json.data do
	json.array! @permissions do |permission| 
		json.id permission.id
		json.group permission.group.name
		json.control permission.control.name
		json.action permission.action.name
		json.(permission,:description,:created_at,:updated_at)
	end
end