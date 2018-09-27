module ApplicationHelper

  def current_user
    @token = Session.find_by(Token: session[:user_id])
    if !@token.nil?
      User.find(@token.user_id)
    end
  end

end
