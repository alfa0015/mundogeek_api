module DeviseRequestSpecHelpers

  include Warden::Test::Helpers

  def login_user_token
  	Group.create([{name:"Administrador"},{name:"User"}])
    user = FactoryGirl.build(:user)
    usuario = {email:user.email,password:user.password,password_confirmation:user.password_confirmation}
    post api_v1_registrations_path,params: {user: usuario}
    token = JSON.parse(response.body)
    return token["token"]
  end
end