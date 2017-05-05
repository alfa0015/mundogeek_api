class Api::V1::AttachmentsController < Api::V1::ApiController
	load_and_authorize_resource
	before_action :authenticate, except:[:index,:show]

	def index
			
	end

	def create
		@product = Product.find(params[:product_id])
		@attachment = @product.attachments.build
		format.json { render json: @attachments }
	end
end