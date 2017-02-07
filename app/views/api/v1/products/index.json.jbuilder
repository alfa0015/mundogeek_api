json.array! @products do |product|
	json.(product, :id, :name, :pricing, :description, :status, :expired, :stock)
end