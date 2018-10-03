class AuthService

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i


  def match_password(user, login_password = "")
    user.encrypted_password == BCrypt::Engine.hash_secret(login_password, user.salt)
  end


  def authenticate(username_or_email = "", login_password = "")

    if EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_name(username_or_email)
    end
    if user && match_password(user, login_password)
      user
    else
      # user.errors.messages[:name] << "Incorrect username or password"
      false
    end
  end


end