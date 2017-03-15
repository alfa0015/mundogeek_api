require 'rails_helper'
RSpec.describe Api::V1::ActionsController, type: :request do
	let(:token){login_user_token}
	let(:action_create){FactoryGirl.create(:action)}
	let(:action_list){FactoryGirl.create_list(:action,10)}
	let(:action_build){FactoryGirl.build(:action)}
	describe "GET /actions" do

		context "con token validos" do
			before :each do
				action_create
				get api_v1_actions_path, params: {token: token}
			end
			it { expect(response).to have_http_status(:ok)}

			it "Should send list Control" do
				json = JSON.parse(response.body)
				expect(json["data"].length).to eq(Action.count)
			end
		end

		context "con token invalido" do
			before :each do 
				action_create
				get api_v1_actions_path
			end
			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al guardar el Producto" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "GET /action/:id" do

		context "con tokan valido" do
			before :each do
				action_create
				get api_v1_action_path(action_create.id),params:{token:token}
			end


			it { expect(response).to have_http_status(:ok)}

			it "manda el action solicitado" do
				json = JSON.parse(response.body)
				expect(json["data"]["id"]).to eq(action_create.id)
			end

		end

		context "con token invalido" do
			before :each do
				action_create
				get api_v1_action_path(action_create.id)
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end	
		end

	end

	describe "POST /actions" do
		let(:action_params){
			{
				name:action_build.name,
				permit:action_build.permit,
				control_id:action_build.control_id
			}
		}
		context "Con Token valido" do
			before :each do
				post api_v1_actions_path, params: { token: token ,ac:action_params }
			end

			it { expect(response).to have_http_status(:ok) }

			it "Crea un Control" do
				expect{
					post api_v1_actions_path, params: {token: token, ac:action_params }
				}.to change(Action,:count).by(1)
			end

			it "Responde con el Control creado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(action_params[:name])
			end
		end
		context "Con Token invalido" do
			before :each do
				post api_v1_actions_path, params: { control:action_params }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end	
		end
	end

	describe "PATCH/PUT /action/:id" do
		let(:action_params){
			{
				name:"new_name"
			}
		}
		context "Con token valido" do
			before :each do
				patch api_v1_action_path(action_create.id), params:{token:token,ac:action_params}
			end

			it { expect(response).to have_http_status(:ok) }

			it "Actualiza la action indicada" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(action_params[:name])
			end
		end

		context "con token invalido" do
			before :each do
				patch api_v1_action_path(action_create.id), params:{ac:action_params}
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end	

		end
	end

	describe "DELETE /action/:id" do
		context "Con token valido" do
			before :each do 
				action_create
			end
			it "Deberia de regresar status ok al eliminar el control indicado" do
				delete api_v1_action_path(action_create.id), params: {token:token}
				expect(response).to have_http_status(:ok)
			end

			it "Elimina el grupo indicado" do 
				expect{
					delete api_v1_action_path(action_create.id),params: {token:token}
					}.to change(Action,:count).by(-1)
			end
		end
	end

end