require 'rails_helper' 
RSpec.describe Api::V1::ActionsController, type: :request do 
	let(:token){login_user_token} 
	let(:token_admin){login_user_admin_token}
	let(:generate_permissions){permissions}
	let(:action_create){FactoryGirl.create(:action)} 
	let(:action_list){FactoryGirl.create_list(:action,10)} 
	let(:action_build){FactoryGirl.build(:action)}

	describe "GET /actions" do

		before :each do
				generate_permissions
		end

		context "Con token Administrador" do

			before :each do
				action_create 
				get api_v1_actions_path, params: {token: token_admin} 
			end

			it { expect(response).to have_http_status(:ok)}

			it "Deveria de mandar la lista de acciones" do 
				json = JSON.parse(response.body)
				expect(json["data"].length).to eq(Action.count) 
			end 

		end

		context "Con token con Usuario" do

			before :each do 
				action_create 
				get api_v1_actions_path, params: {token: token} 
			end

			it { expect(response).to have_http_status(:unauthorized)}

			it "responde con errores al no tener permisos para acceder" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end 

		end

		context "Sin enviar token" do

			before :each do  
				action_create 
				get api_v1_actions_path 
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar las acciones" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end

		end

	end 
 
	describe "GET /action/:id" do

		before :each do
				generate_permissions
		end

		context "Con Token Administrador" do
			before :each do
				action_create 
				get api_v1_action_path(action_create.id), params: {token: token_admin} 
			end

			it { expect(response).to have_http_status(:ok)} 
 
			it "manda el action solicitado" do 
				json = JSON.parse(response.body) 
				expect(json["data"]["id"]).to eq(action_create.id) 
			end 

		end
 
		context "con token Usuario" do

			before :each do 
				action_create 
				get api_v1_action_path(action_create.id),params:{token:token} 
			end 
 
 
			it { expect(response).to have_http_status(:unauthorized)} 
 
			it "responde con errores al consultar la accion" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end  
 
		end 
 
		context "Sin enviar token" do 
			before :each do 
				action_create 
				get api_v1_action_path(action_create.id) 
			end
 
			it { expect(response).to have_http_status(:unauthorized) } 
 
			it "responde con errores al consultar la accion" do
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
			} 
		} 

		before :each do
				generate_permissions
		end

		context "Con Token Administrador" do

			before :each do 
				post api_v1_actions_path, params: { token: token_admin ,ac:action_params } 
			end 
 
			it { expect(response).to have_http_status(:ok) } 
 
			it "Crea una accion" do 
				expect{ 
					post api_v1_actions_path, params: {token: token_admin, ac:action_params } 
				}.to change(Action,:count).by(1) 
			end 
 
			it "Responde con la accion creada" do 
				json = JSON.parse(response.body) 
				expect(json["data"]["name"]).to eq(action_params[:name]) 
			end 

		end

		context "Con Token Usuario" do

			before :each do 
				post api_v1_actions_path, params: { token: token ,ac:action_params } 
			end 
 
			it { expect(response).to have_http_status(:unauthorized) } 
 
			it "Al Crea una accion sin permisos no se guardara en la base de datos" do 
				expect{ 
					post api_v1_actions_path, params: {token: token, ac:action_params } 
				}.to change(Action,:count).by(0) 
			end 
 
			it "responde con errores al intentar crear una accion sin permisos" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end
			
		end

		context "Sin enviar token" do 
			before :each do 
				post api_v1_actions_path, params: { control:action_params } 
			end 
 
			it { expect(response).to have_http_status(:unauthorized) } 
 
			it "responde con errores al crear la accion sin token" do
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

		before :each do
				generate_permissions
		end

		context "Con token Administrador" do 
			before :each do 
				patch api_v1_action_path(action_create.id), params:{token:token_admin,ac:action_params} 
			end 
 
			it { expect(response).to have_http_status(:ok) } 
 
			it "Actualiza la action indicada" do 
				json = JSON.parse(response.body) 
				expect(json["data"]["name"]).to eq(action_params[:name]) 
			end 
		end

		context "Con token Usuario" do 
			before :each do 
				patch api_v1_action_path(action_create.id), params:{token:token,ac:action_params} 
			end 
 
			it { expect(response).to have_http_status(:unauthorized) } 
 
			it "responde con errores al actualizar la accion sin permisos" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end

		end 
 
		context "con token invalido" do 
			before :each do 
				patch api_v1_action_path(action_create.id), params:{ac:action_params} 
			end 
 
			it { expect(response).to have_http_status(:unauthorized) } 
 
			it "responde con errores al actualizar la accion" do 
				json = JSON.parse(response.body) 
				expect(json["errors"]).to_not be_empty 
			end   
 
		end 

	end 
 
	describe "DELETE /action/:id" do 

		before :each do
				generate_permissions
		end

		context "Con token Administrador" do 
			before :each do  
				action_create 
			end 
			it "Deberia de regresar status ok al eliminar la accion indicada" do 
				delete api_v1_action_path(action_create.id), params: {token:token_admin} 
				expect(response).to have_http_status(:ok) 
			end 
 
			it "Elimina la accion indicada" do  
				expect{ 
					delete api_v1_action_path(action_create.id),params: {token:token_admin} 
					}.to change(Action,:count).by(-1) 
			end 
		end

		context "Con token Usuario" do 
			before :each do  
				action_create 
			end 

			it "Deberia de regresar status unauthorized al eliminar la accion indicada sin permisos" do 
				delete api_v1_action_path(action_create.id), params: {token:token} 
				expect(response).to have_http_status(:unauthorized) 
			end 
 
		end

		context "Sin enviar token" do 
			before :each do  
				action_create 
			end 

			it "Deberia de regresar status unauthorized al eliminar la accion sin enviar un token" do 
				delete api_v1_action_path(action_create.id), params: {token:token} 
				expect(response).to have_http_status(:unauthorized) 
			end 
 
		end

	end 
 
end