require 'rails_helper'
RSpec.describe Api::V1::ProductsController, type: :request do
	describe "GET /products" do
		before :each do
			FactoryGirl.create_list(:product,10)
			get api_v1_products_path
		end

		it { expect(response).to have_http_status(:ok)}

		it "mande la lista de Productos" do
			json = JSON.parse(response.body)
			expect(json["data"].length).to eq(Product.count)
		end
	end

	describe "GET /product/:id" do
		before :each do
			@product = FactoryGirl.create(:product)
			get api_v1_product_path(@product.id)
		end

		it { expect(response).to have_http_status(:ok)}

		it "manda el producto solicitado" do
			json = JSON.parse(response.body)
			expect(json["data"]["id"]).to eq(@product.id)
		end

		it "Manda los atributos del Producto" do
			json = JSON.parse(response.body)
			expect(json["data"].keys).to contain_exactly("id", "name", "pricing", "description", "status", "expired", "stock","attachments")
		end
	end

	describe "POST /products" do
		context "Con Token Valido" do
			before :each do
				@token = login_user_token
				producto = FactoryGirl.build(:product)
				@product = {name:producto.name,pricing:producto.pricing,description:producto.description,status:producto.status,expired:producto.expired,stock:producto.stock}
				post api_v1_products_path, params: {token: @token,product:@product}
			end

			it { expect(response).to have_http_status(:ok) }

			it "Crea un Producto" do
				expect{
					post api_v1_products_path, params: {token: @token,product:@product }
				}.to change(Product,:count).by(1)
			end

			it "Responde con el Producto creado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(@product[:name])
			end
		end

		context "Con Token Invalido" do
			before :each do
				producto = FactoryGirl.build(:product)
				@product = {name:producto.name,pricing:producto.pricing,description:producto.description,status:producto.status,expired:producto.expired,stock:producto.stock}
				post api_v1_products_path, params: {product:@product}
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al guardar el Producto" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end

		end
	end

	describe "PATCH/PUT /product/:id" do
		context "Con Token Valido" do
			before :each do
				@token = login_user_token
				@product = FactoryGirl.create(:product)
				patch api_v1_product_path(@product.id), params:{token:@token,product:{name:"new_name"}}
			end
			it { expect(response).to have_http_status(:ok) }

			it "Actualiza el Producto indicado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq("new_name")
			end
		end

		context "Con Token invalido" do
			before :each do
				@product = FactoryGirl.create(:product)
				patch api_v1_product_path(@product.id), params:{ product:{name:"new_name"} }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "Debe responder con el erros" do 
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "DELETE /product/:id" do
		context "Con Token Valido" do
			before :each do
				@token = login_user_token
				@product = FactoryGirl.create(:product)
			end

			it "Deberia de regresar status ok al eliminar el producto indicado" do
				delete api_v1_product_path(@product.id), params: {token:@token}
				expect(response).to have_http_status(:ok)
			end

			it "Elimina el menu indicado" do 
				expect{
					delete api_v1_product_path(@product.id),params: {token:@token}
					}.to change(Product,:count).by(-1)
			end
		end

		context "Con Token Invalido" do
			before :each do
				@product = FactoryGirl.create(:product)
				delete api_v1_product_path(@product.id)
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al guardar el menu" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end

		end
	end
end