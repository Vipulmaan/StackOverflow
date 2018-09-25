class SessionsController < ApplicationController

  before_action :authenticate_user, :only => [:home]
  before_action :save_login_state, :only => [:login, :login_attempt]



  def login_attempt
    authorized_user = User.authenticate(params[:username_or_email], params[:login_password])
    if authorized_user
      session[:user_id] = authorized_user.id
      flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.name}"
      redirect_to '/all_questions'
    else
      render "login"
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to(root_url)
  end

  def home

  end
end