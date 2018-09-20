module UsersHelper


  def isadmin?(user)
    session[:user_id] = 1
    if session[:user_id] == user.id
      return true
    else
      return false
    end
  end


  def current_user
    session[:user_id] = 1
    User.find(1)
  end
end
