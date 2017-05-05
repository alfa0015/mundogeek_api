class Api::V1::ApiController < ApplicationController
	include CanCan::ControllerAdditions

	#Cambia el error 500 internal server de Cancancan unauthorized por un 401 personalizado
	rescue_from CanCan::AccessDenied do |exception|
		render json:{errors:"Acceso restringido, no tienes los suficientes privilegios"},status: :unauthorized
	end

	#Cambia el error 404 por uno personalizado al no encontrar un registro
	rescue_from ActiveRecord::RecordNotFound do |exception|
		render json:{errors:"Record not Found"},status: :not_found
	end

	def authenticate
		token_str = params[:token]
		token = Token.find_by(token: token_str)

		if token.nil? || !token.is_valid?
			render json:{errors:"Tu token es invalido"},status: :unauthorized
		else
			return @current_user = token.user
		end
	end

end