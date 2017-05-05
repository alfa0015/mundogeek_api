require 'rails_helper'
RSpec.describe Api::V1::GroupsController, type: :request do

	let(:token){login_user_token}
	let(:token_admin){login_user_admin_token}
	let(:generate_permissions){permissions}
	let(:group){FactoryGirl.create(:group)}
	let(:group_buil){FactoryGirl.build(:group)}
	
	describe "GET /groups" do

		before :each do
			generate_permissions
		end

		context "Con Token Administrador" do
			before :each do
				group = FactoryGirl.create_list(:group,10)
				get api_v1_groups_path, params: {token: token_admin}
			end

			it { expect(response).to have_http_status(:ok)}

			it "mande la lista de Grupos" do
				json = JSON.parse(response.body)
				expect(json["data"].length).to eq(Group.count)
			end
		end

		context "Con Token Usuario" do
			before :each do
				group = FactoryGirl.create_list(:group,10)
				get api_v1_groups_path, params: {token: token}
			end

			it { expect(response).to have_http_status(:unauthorized)}

			it "responde con errores al guardar el Grupo sin tener permisos" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

		context "Con Token Invalido" do 
			before :each do
				group = FactoryGirl.create_list(:group,10)
				get api_v1_groups_path
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar los Grupos sin enviar el token" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

	end

	describe "GET /group/:id" do

		before :each do
			generate_permissions
		end

		context "Con Token Administrador" do
			before :each do
				get api_v1_group_path(group.id),params:{token:token_admin}
			end

			it { expect(response).to have_http_status(:ok)}

			it "manda el grupo solicitado" do
				json = JSON.parse(response.body)
				expect(json["data"]["id"]).to eq(group.id)
			end

			it "Manda los atributos del Producto" do
				json = JSON.parse(response.body)
				expect(json["data"].keys).to contain_exactly("id", "name")
			end
		end

		context "Con Token Usuario" do

			before :each do
				get api_v1_group_path(group.id),params:{token:token}
			end

			it { expect(response).to have_http_status(:unauthorized)}

			it "responde con errores al consultar el grupo sin tener permisos" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end

		end

		context "Sin enviar Token" do
			before :each do
				get api_v1_group_path(group.id)
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "responde con errores al consultar el grupo" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end			
		end
	end

	describe "POST /products" do
		
		let(:group_params){
			{
				name:group_buil.name
			}
		}

		before :each do
			generate_permissions
		end

		context "Con token Administrador" do
			before :each do
				post api_v1_groups_path, params: { token: token_admin,group:group_params }
			end

			it { expect(response).to have_http_status(:ok) }

			it "Crea un Grupo" do
				expect{
					post api_v1_groups_path, params: {token: token_admin,group:group_params }
				}.to change(Group,:count).by(1)
			end

			it "Responde con el Grupo creado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(group_params[:name])
			end
		end

		context "Con token Usuario" do
			before :each do
				post api_v1_groups_path, params: { token: token,group:group_params }
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "Crea un Grupo" do
				expect{
					post api_v1_groups_path, params: {token: token,group:group_params }
				}.to change(Group,:count).by(0)
			end

			it "responde con errores al guardar el Grupo sin permisos" do
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

		context "Sin enviar token" do
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


		let(:group_params){
			{
				name:"new_name"
			}
		}

		before :each do
			generate_permissions
		end

		context "Con token Administrador" do
			before :each do
				patch api_v1_group_path(group.id), params:{token:token_admin,group:group_params}
			end

			it { expect(response).to have_http_status(:ok) }

			it "Actualiza el Grupo indicado" do
				json = JSON.parse(response.body)
				expect(json["data"]["name"]).to eq(group_params[:name])
			end
		end

		context "Con token Usuario" do
			before :each do
				patch api_v1_group_path(group.id), params:{token:token,group:group_params}
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "Debe responder con el errores al tratar de actualizar un grupo sin permisos" do 
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end

		context "Sin enviar token" do
			before :each do
				patch api_v1_group_path(group.id), params:{group:group_params}
			end

			it { expect(response).to have_http_status(:unauthorized) }

			it "Debe responder con el errores al tartar de actualizar sin enviar token" do 
				json = JSON.parse(response.body)
				expect(json["errors"]).to_not be_empty
			end
		end
	end

	describe "DELETE /group/:id" do

	    let(:group){ FactoryGirl.create(:group) } 
	    
	    before :each do
	        generate_permissions
	    end

	    context "Con token administrador" do 
	      before :each do  
	        group 
	      end 
	 
	      it "Deberia de regresar status ok al eliminar el control indicado" do 
	        delete api_v1_group_path(group.id), params: {token:token_admin} 
	        expect(response).to have_http_status(:ok) 
	      end 
	 
	      xit "Elimina el grupo indicado" do 
	        expect{ 
	          delete api_v1_group_path(group.id),params: {token:token_admin} 
	          }.to change(Group,:count).by(-1) 
	      end 
	    end

	    context "con token Usuario" do 
	      before :each do 
	        group 
	        delete api_v1_group_path(group.id), params: {token: token} 
	      end 
	 
	      it { expect(response).to have_http_status(:unauthorized) } 
	 
	      it "responde con errores al eliminar el group sin tener permisos" do 
	        json = JSON.parse(response.body) 
	        expect(json["errors"]).to_not be_empty 
	      end 
 
    end 
 
    context "Sin enviar un token" do 
      before :each do 
        group 
        delete api_v1_group_path(group.id) 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al eliminar el group sin tener permisos" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end 
 
    end 
  end

end