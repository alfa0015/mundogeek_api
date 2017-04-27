require 'rails_helper' 
RSpec.describe Api::V1::ControlsController, type: :request do 
  let(:token){login_user_token} 
  describe "GET /controls" do 
    let(:control){FactoryGirl.create_list(:control,10)} 
    let(:control_params){} 
     
    context "Con token valido" do 
       
      before :each do 
        control 
        get api_v1_controls_path, params: {token: token} 
      end 
 
      it { expect(response).to have_http_status(:ok)} 
 
      it "Should send list Control" do 
        json = JSON.parse(response.body) 
        expect(json["data"].length).to eq(Control.count) 
      end 

    end 
 
    context "Con token invalido" do 
       
      before :each do 
        control 
        get api_v1_controls_path 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al guardar el Producto" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end 
 
    end 
 
  end 
 
  describe "GET /control/:id" do 
    let(:control){ FactoryGirl.create(:control) } 
    context "with token valid" do 
       
      before :each do 
        control 
        get api_v1_control_path(control.id),params:{token:token} 
      end 
 
      it { expect(response).to have_http_status(:ok)} 
 
      it "manda el control solicitado" do 
        json = JSON.parse(response.body) 
        expect(json["data"]["id"]).to eq(control.id) 
      end 
 
      it "Manda los atributos del Control" do 
        json = JSON.parse(response.body) 
        expect(json["data"].keys).to contain_exactly("id", "name", "actions") 
      end 
 
    end 
 
 
    context "with token invalid" do 
      before :each do 
        control 
        get api_v1_control_path(control.id) 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al consultar el grupo" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end   
 
    end 
 
  end 
 
  describe "POST /controls" do 
    let(:control){ FactoryGirl.build(:control) } 
    let(:action){FactoryGirl.create(:action)}
    let(:control_params){ 
      { 
        name:control.name
      } 
    } 
    let(:action_params){
      [
        action.id
      ]
    }
    context "con token valido" do 
      before :each do 
        post api_v1_controls_path, params: { token: token,control:control_params,actions:action_params} 
      end 
 
      it { expect(response).to have_http_status(:ok) } 
 
      it "Crea un Control" do 
        expect{ 
          post api_v1_controls_path, params: {token: token, control:control_params,actions:action_params} 
        }.to change(Control,:count).by(1) 
      end 
 
      it "Responde con el Control creado" do 
        json = JSON.parse(response.body) 
        expect(json["data"]["name"]).to eq(control_params[:name]) 
      end 

      it "Responde con las acciones asociadas" do 
        json = JSON.parse(response.body) 
        expect(json["data"]["actions"].length).to eq(action_params.count) 
      end 
 
    end 
 
    context "con token invalido" do 
      before :each do 
        post api_v1_controls_path, params: { control:control_params } 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al consultar el grupo" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end   
 
    end 
 
  end 
 
  describe "PUT/PATCH /control/:id" do 
    let(:control){ FactoryGirl.create(:control) } 
    let(:control_params){ 
      { 
        name:"new_name" 
      } 
    } 
    context "con token valido" do 
      before :each do 
        patch api_v1_control_path(control.id), params:{token:token,control:control_params} 
      end 
 
      it { expect(response).to have_http_status(:ok) } 
 
      it "Actualiza el Control indicado" do 
        json = JSON.parse(response.body) 
        expect(json["data"]["name"]).to eq(control_params[:name]) 
      end 
    end 
 
    context "con token invalido" do 
      before :each do 
        patch api_v1_control_path(control.id), params:{control:control_params} 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al consultar el grupo" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end   
 
    end 
  end 
 
  describe "DELETE /control/:id" do 
    let(:control){ FactoryGirl.create(:control) } 
 
    context "con token valido" do 
      before :each do  
        control 
      end 
 
      it "Deberia de regresar status ok al eliminar el control indicado" do 
        delete api_v1_control_path(control.id), params: {token:token} 
        expect(response).to have_http_status(:ok) 
      end 
 
      it "Elimina el grupo indicado" do  
        expect{ 
          delete api_v1_control_path(control.id),params: {token:token} 
          }.to change(Control,:count).by(-1) 
      end 
    end 
 
    context "con token invalido" do 
      before :each do 
        control 
        delete api_v1_control_path(control.id) 
      end 
 
      it { expect(response).to have_http_status(:unauthorized) } 
 
      it "responde con errores al eliminar el grupo" do 
        json = JSON.parse(response.body) 
        expect(json["errors"]).to_not be_empty 
      end 
 
    end 
  end 
end