class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  attr_accessor :salts, :encrypted_passwords

  public

  def new
    @user = User.new
  end

  def index
    @questions = Question.all
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
    # @user.salt = self.salts
    # @user.encrypted_password = self.encrypted_passwords

    if @user.password == @user.password_confirmation
      if @user.save
        flash[:notice] = 'Successful sign up ....'
        redirect_to(root_url)

      else
        flash[:notice] = 'Invalid entry....'
        render 'new'
      end
    else
      flash[:notice] = 'Password and confirmation password are not same....'
      render 'new'
    end
  end


  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User successfully deleted!'
    redirect_to '/logout'
  end


end