class Api::V1::GroupsController < Api::V1::ApiController
  before_action :authenticate
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    @groups = Group.all
  end

  def show
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render "/api/v1/groups/show"
    else
      render json:{errors:@group.errors.full_messages},status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      render "/api/v1/groups/show"
    else
      render json:{errors:@group.errors.full_messages},status: :unprocessable_entity
    end
  end

  def destroy
    if @group.destroy
      render json:{messages:"El grupo fue eliminado"},status: :ok
    else
      render json:{errors:@group.errors.full_messages},status: :unprocessable_entity
    end
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

    def group_params
      params.require(:group).permit(:name)
    end
end
