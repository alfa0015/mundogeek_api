class Api::V1::SessionsController < Devise::SessionsController
  def create
    warden.authenticate!(:scope => :user)
    user = warden.authenticate!(auth_options)
    user = User.where(id: current_user.id).select('id','email')
    #token = Token.find(current_user.id)
    render :status => 200,
           :json => { :success => true,
                      :info => "Logged in",
                      :user => user,
                      #:token => token.token
           }
  end

  def destroy
    sign_out(resource_name)
    return render :json => {:success => true}
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end
  
end