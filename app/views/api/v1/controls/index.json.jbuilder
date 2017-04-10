json.data do 
  json.array! @controls do |control| 
    json.(control, :id,:name) 
  end 
end