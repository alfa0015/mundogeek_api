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

  def login_user_admin_token
  	Group.create([{name:"Administrador"},{name:"User"}])
    user = FactoryGirl.build(:user)
    User.create(email:user.email,password:user.password,group_id:1)
    usuario = User.find_by email: user.email
    token = usuario.tokens.generate_token
    return token.token
  end

end