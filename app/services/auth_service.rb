class AuthService

  def initialize(params)
    @users = params[:class]
    @name = params[:name]
    @password = params[:password]
  end


  def auth
    @users.where(name: @name , password: @password)
  end


end