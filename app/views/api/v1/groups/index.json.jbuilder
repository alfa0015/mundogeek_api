json.data do 
	json.array! @groups	do |group|
		json.(group, :id, :name)
	end
end