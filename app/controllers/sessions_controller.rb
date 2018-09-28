class SessionsController < ApplicationController

  before_action :authenticate_user, :only => [:home]
  before_action :save_login_state, :only => [:login, :login_attempt]
  attr_accessor :salt, :token

  def encrypt_password(id)

      self.salt = BCrypt::Engine.generate_salt
      self.token= BCrypt::Engine.hash_secret(id, salt)
  end

  def create
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      token = encrypt_password(authorized_user.id)
      @session = Session.new(user_id: authorized_user.id, Token: token, Login_time: Time.now, Logout_time: " ", State: true, salt: salt)
      @session.save
    end
    if authorized_user
      session[:user_id] = token
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to '/all_questions'
    else
      flash[:notice] = "Username or password is incorrect...."
      render "login"
    end
  end

  def logout
    #session.delete(:user_id)
    #@current_user = nil

    # render plain: session.keys
    # return nil
    #debugger
    session[:user_id] = nil
    redirect_to(root_url)
  end

  def home
    redirect_to(root_url)
  end
end