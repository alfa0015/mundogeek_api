class Api::V1::ProductsController < Api::V1::ApiController
	before_action :authenticate, except:[:index,:show]
	load_and_authorize_resource except:[:index,:show]
	before_action :set_product, only: [:show, :edit, :update, :destroy]
	def index
		@products = Product.all.includes(:attachments)
	end

	def show
	end

	def create
		@product = Product.new(product_params)
    	#@product.attachments = params[:attachments]
    	if @product.save
    		if params[:attachments] 
    			params[:attachments].each do |picture|
    				@product.attachments.create(image:picture)
    			end
    		end
    		render "/api/v1/products/show"
    	else
    		render json:{errors:@product.errors.full_messages},status: :unprocessable_entity
    	end
	end

	def update
		if @product.update(product_params)
			render "/api/v1/products/show"
		else
			render json:{errors:@product.errors},status: :unprocessable_entity
		end
	end

	def destroy
		if @product.destroy
			render json:{messages:"El producto fue eliminado"},status: :ok
		else
			render json:{errors:@product.errors.full_messages},status: :unprocessable_entity
		end
	end

	private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :pricing, :description,:status,:expired,:attachments,:stock)
    end
end