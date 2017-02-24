json.data do
	json.array! @products do |product|
		json.id product.id
		json.name product.name
		json.pricing product.pricing
		json.description product.description
		json.status product.status
		json.expired product.expired
		json.stock product.stock
		json.attachments do
			json.array!(product.attachments) do |picture|
				json.image_url picture.image.url
			end
		end
	end
end