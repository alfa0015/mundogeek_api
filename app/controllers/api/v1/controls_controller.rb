class Api::V1::ControlsController < Api::V1::ApiController
	before_action :authenticate 
  	before_action :set_control, only: [:show, :edit, :update, :destroy] 
 
	def index 
		@controls = Control.all 
	end 

	def show 
	end 

	def create 
		@control = Control.new(control_params)
		@control.actions = params[:actions]
		if @control.save 
	  		render "/api/v1/controls/show", status: :ok 
		else 
	  		render json:{errors:@control.errors.full_messages},status: :unprocessable_entity 
		end 
	end 

	def update 
		if @control.update(control_params) 
	  		render "/api/v1/controls/show",status: :ok 
		else 
	  		render json:{errors:@control.errors.full_messages},status: :unprocessable_entity 
		end 
	end 

	def destroy 
		if @control.destroy 
	  		render json:{message:"El control fue eliminado"}, status: :ok 
		else 
	  		render json:{errors:@control.errors.full_messages},status: :unprocessable_entity 
		end 
	end 

	private 

		def set_control 
		  @control = Control.find(params[:id]) 
		end 

		def control_params
		  params.require(:control).permit(:name,:actions)
		end
end