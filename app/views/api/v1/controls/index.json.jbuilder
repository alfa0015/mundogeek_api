json.data do 
  json.array! @controls do |control| 
    json.(control, :id,:name)
    json.actions do
		json.array!(control.actions) do |action|
			json.id action.id
			json.name action.name
		end
	end
  end 
end