class Api::V1::RegistrationsController < ApplicationController
  
  #respond_to :json
  def create
    if !params[:user]
      render json:{error:"User params is mising"}
    else
      @user = User.new(user_params)
      if @user.save
        @token = @user.tokens.generate_token()
        render "/api/v1/users/show"
      else
        warden.custom_failure!
        render json:{errors:@user.errors},status: :unprocessable_entity
      end
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end