class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  def create
    warden.authenticate!(:scope => :user)
    user = warden.authenticate!(auth_options)
    user = User.where(id: current_user.id).select('id','email')
    token = Token.find(current_user.id)
    render :status => :ok,
           :json => { :success => true,
                      :info => "Logged in",
                      :user => user,
                      :token => token.token
           }
  end

  def logout
    #tokens = Token.last
    #render status: :ok, json: {message:"ok",token:tokens}
    sign_out(resource_name)
    render status: :ok, json: {message: "You have successfully logged out"}
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]},:status => :unauthorized
  end
  
end