require 'rails_helper'
RSpec.describe Api::V1::SessionsController, type: :request do
	describe "PÖST /sessions" do
		context "Con Datos Validos" do
			before :each do 
				user = FactoryGirl.build(:user)
				@usuario = {email:user.email,password:user.password,password_confirmation:user.password_confirmation}
				post '/api/v1/registrations', params: {user: @usuario}
			end

			it "regresa las credenciales luego de un login exitoso" do
				post api_v1_sessions_path, params: {user: @usuario}
				expect(response).to have_http_status(:ok)
			end

			it "Manda los atributos del Usuario" do
				json = JSON.parse(response.body)
				expect(json.keys).to contain_exactly("id","email","token")
			end
		end

		describe "Con Datos Invalido" do
			before :each do 
				user = FactoryGirl.build(:user)
				@usuario = {email:user.email,password:user.password,password_confirmation:user.password_confirmation}
				post '/api/v1/registrations', params: {user: @usuario}
			end
			it "responde con errores al intentar acceder a los contacts" do
				post api_v1_sessions_path, params: {user: {email:"123",password:"123",password_confirmation:"123"}}
				expect(response).to have_http_status(:unauthorized)
			end
		end
	end
end