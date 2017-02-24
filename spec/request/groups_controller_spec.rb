require 'rails_helper'
RSpec.describe Api::V1::GroupsController, type: :request do
	describe "GET /products" do

		context "Con Token Valido" do
			before :each do
				@token = login_user_token
				group = FactoryGirl.create_list(:group,10)
				get api_v1_groups_path, params: {token: @token}
			end

			it { expect(response).to have_http_status(:ok)}

			it "mande la lista de Productos" do
				json = JSON.parse(response.body)
				expect(json["data"].length).to eq(Group.count)
			end
		end

		context "Con Token Invalido" do 
			before :each do
				@token = login_user_token
				group = FactoryGirl.create_list(:group,10)
				get api_v1_groups_path
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al guardar el Producto" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

	end

	describe "GET /product/:id" do

		context "Con Token Valido" do
			before :each do
				@token = login_user_token
				@group = FactoryGirl.create(:group)
				get api_v1_group_path(@group.id),params:{token:@token}
			end

			it { expect(response).to have_http_status(:ok)}

			it "manda el grupo solicitado" do
				json = JSON.parse(response.body)
				expect(json["data"]["id"]).to eq(@group.id)
			end

			it "Manda los atributos del Producto" do
				json = JSON.parse(response.body)
				expect(json["data"].keys).to contain_exactly("id", "name")
			end
		end

		context "Con Token Invalido" do
			before :each do
				@group = FactoryGirl.create(:group)
				get api_v1_group_path(@group.id)
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end			
		end
	end

	describe "POST /products" do
		
		let(:group){ producto = FactoryGirl.build(:group) }
		let(:group_params){
			{
				name:group.name
			}
		}

		context "Con token valido" do
			before :each do
				@token = login_user_token
				post api_v1_groups_path, params: { token: @token,group:group_params }
			end

			it { expect(response).to have_http_status(:ok) }

			it "Crea un Grupo" do
				expect{
					post api_v1_groups_path, params: {token: @token,group:group_params }
				}.to change(Group,:count).by(1)
			end

			it "Responde con el Grupo creado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(group_params[:name])
			end
		end

		context "Con token Invalido" do
			before :each do
				post api_v1_groups_path, params: { group:group_params }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al guardar el Grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "PATCH/PUT /group/:id" do
		let(:group){ FactoryGirl.create(:group) }
		let(:group_params){
			{
				name:"new_name"
			}
		}
		context "con token valido" do
			before :each do
				@token = login_user_token
				patch api_v1_group_path(group.id), params:{token:@token,group:group_params}
			end

			it { expect(response).to have_http_status(:ok) }

			it "Actualiza el Producto indicado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(group_params[:name])
			end
		end

		context "con token Invalido" do
			before :each do
				patch api_v1_group_path(group.id), params:{group:group_params}
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "Debe responder con el erros" do 
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "DELETE /group/:id" do
		let(:group){ FactoryGirl.create(:group) }
		context "con token valido" do
			before :each do 
				@token = login_user_token
				group
			end

			it "Deberia de regresar status ok al eliminar el grupo indicado" do
				delete api_v1_group_path(group.id), params: {token:@token}
				expect(response).to have_http_status(:ok)
			end

			it "Elimina el grupo indicado" do 
				expect{
					delete api_v1_group_path(group.id),params: {token:@token}
					}.to change(Group,:count).by(-1)
			end

		end

		context "con token Invalido" do
			before :each do
				group
				delete api_v1_group_path(group.id)
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al eliminar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end
end