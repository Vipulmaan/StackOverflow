 class ApplicationController < ActionController::Base

  # rescue_from UsersController::Forbidden, :with => :render_403

  include Error::ErrorHandler

  include ApplicationHelper



  def authenticate_user

    if session[:user_id]

      @token = Session.find_by!(Token: session[:user_id])

      @current_user = User.find(@token.user_id)
      true
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end


  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      false
    else
      true
    end
  end


  def is_admin?(user)

    if session[:user_id] == user.id
      return true
    else
      return false
    end
  end

  def user_logged_in?
    if session[:user_id]
      return true
    else
      render root_url
      return false
    end
  end


end

