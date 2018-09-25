class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  attr_accessor :salts, :encrypted_passwords

  before_action :user_exists?, :only => [:show]
  before_action :authenticate_user, :except => [:new, :create]

  public

  def new
    @user = User.new
  end

  def index
    if params[:data]
      search_service = SearchService.new({class: User, column: params[:column], data: params[:data]})
      @users = search_service.search
    else
      @users = User.all
    end
  end


  def show
    @user = User.find(params[:id])
  end


  def create
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

  private

  def user_exists?
    unless User.exists?(id: params[:id])
      render plain: "user not exist"
    end
  end


end