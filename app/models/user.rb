class User < ApplicationRecord

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_questions, class_name: "UserFavoriteQuestion", dependent: :destroy
  has_many :votes, dependent: :destroy
  attr_accessor :username, :password, :password_confirmation
  attr_accessor :password
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :presence => true, :length => { :in => 6..20 }
  validates :password_confirmation, :presence => true, :length => { :in => 6..20 }
  before_save :encrypt_password
  after_save :clear_password


  def encrypt_password
    if password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end
  def clear_password
    self.password = nil
  end

  def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_name(username_or_email)
    end
    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end


  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

end
