json.data do 
  json.array! @actions do |action| 
    json.(action, :id,:name) 
  end 
end