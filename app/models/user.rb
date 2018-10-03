class User < ApplicationRecord

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_questions, class_name: "UserFavoriteQuestion", dependent: :destroy
  has_many :votes, dependent: :destroy
  attr_accessor :username, :password, :password_confirmation
  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\Z/i
  validates :name, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :password, :presence => true, :length => { :in => 6..20 }, :on => :create
  validates :password, :presence => true, :length => { :in => 6..20 }, :on => :update, if: -> { password.present? }
  validates :password_confirmation, :presence => true, :length => { :in => 6..20 }, :on => :update, if: -> { password_confirmation.present? }
  validates :password_confirmation, :presence => true, :length => { :in => 6..20 }, :on => :create
  before_save :encrypt_password
  after_save :clear_password


  def encrypt_password
    if self.password.present?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end
end
