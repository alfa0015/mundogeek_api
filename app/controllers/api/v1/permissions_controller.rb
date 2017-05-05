class Api::V1::PermissionsController < Api::V1::ApiController
	before_action :authenticate
	load_and_authorize_resource
	before_action :set_permission, only: [:show, :edit, :update, :destroy]

	def index
		@permissions = Permission.all
	end

	def show
	end

	def create
		@permission = Permission.new(permissions_params)
		if @permission.save
			render "/api/v1/permissions/show", status: :ok
		else
			render json:{errors:@permission.errors.full_messages},status: :unprocessable_entity
		end
	end

	def update
		if @permission.update(permissions_params)
			render "/api/v1/permissions/show", status: :ok
		else
			render json:{errors:@permission.errors.full_messages},status: :unprocessable_entity
		end
	end

	def destroy
		if @permission.destroy
			render json:{messages:"El permission fue eliminado"},status: :ok
		else
			render json:{errors:@permission.errors.full_messages},status: :unprocessable_entity
		end
	end

	private
		def set_permission
			@permission = Permission.find(params[:id])
		end

		def permissions_params
			params.require(:permission).permit(:group_id,:control_id,:action_id,:description)
		end
end