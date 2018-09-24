class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  attr_accessor :salts, :encrypted_passwords

  before_action :encrypt_password, only: [:create]
  after_action :clear_password

  private

  def encrypt_password

    if params[:user][:password].present?
      self.salts = BCrypt::Engine.generate_salt
      self.encrypted_passwords = BCrypt::Engine.hash_secret(params[:user][:password], self.salts)
    end
  end

  def clear_password
    params[:password]
  end

  public

  def new
    @user = User.new
  end

  def index

    @questions = Question.all.sort_by do |question|
      question.votes.sum(:vote)
    end.reverse

  end


  def show
    @user = User.find(params[:id])
  end

  def all_users
    @users = User.all
  end

  def create
    # render plain:  params[:user]
    @user = User.new(user_params)
    @user.salt = self.salts
    @user.encrypted_password = self.encrypted_passwords


    if @user.save
      flash[:notice] = 'Successful sign up ....'
      redirect_to(root_url)

    else
      flash[:notice] = 'Invalid entry....'
      render 'new'
    end
  end


  def user_params
    if params[:password] == params[:password_confirmation]
      params.require(:user).permit(:name, :email)
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User successfully deleted!'
    redirect_to '/logout'
  end


end