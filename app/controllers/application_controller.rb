class ApplicationController < ActionController::Base



  def authenticate_user
    if session[:user_id]
      # set current user object to @current_user object variable
      @current_user = User.find session[:user_id]
      return true
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end
  def save_login_state
    if session[:user_id]
      redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end


  def isadmin?(user)

    if session[:user_id] == user.id
      return true
    else
      return false
    end
  end


  def current_user

    User.find_by(id: session[:user_id])
  end


end

