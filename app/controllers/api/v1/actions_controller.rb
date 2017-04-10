class Api::V1::ActionsController < Api::V1::ApiController 
  before_action :authenticate 
  before_action :set_action, only: [:show, :edit, :update, :destroy] 
 
  def index 
    @actions = Action.all   
  end 
 
  def show 
  end 
 
  def create 
    @action = Action.new(action_params) 
    if @action.save 
      render "/api/v1/actions/show",status: :ok 
    else 
      render json:{erros:@action.errors.full_messages},status: :unprocessable_entity 
    end 
  end 
 
  def update 
    if @action.update(action_params) 
      render "/api/v1/actions/show", status: :ok 
    else 
      render json:{erros:@action.errors.full_messages},status: :unprocessable_entity 
    end 
  end 
 
  def destroy 
    if @action.destroy 
      render json:{message:"La accion fue eliminada"}, status: :ok 
    else 
      render json:{erros:@action.errors.full_messages},status: :unprocessable_entity 
    end 
  end 
 
  private 
 
    def set_action 
      @action = Action.find(params[:id]) 
    end 
 
    def action_params 
      params.require(:ac).permit(:name,:permit,:control_id) 
    end 
end 