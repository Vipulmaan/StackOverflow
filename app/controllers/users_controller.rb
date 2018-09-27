class UsersController < ApplicationController

  before_action :save_login_state, :only => [:new, :create]
  #attr_accessor :salts, :encrypted_passwords

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

    if @user.password == @user.password_confirmation
      if @user.save
        #debugger
        flash[:notice] = 'Successful sign up ....'
        redirect_to(root_url)


      else
        flash[:notice] = 'Invalid entry....'
        render 'new'
      end
    else
      flash[:error] = 'Password and confirmation password are not same....'
      render 'new'
    end
  end





  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User successfully deleted!'
    redirect_to '/logout'
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    user=User.find(params[:id])
    #debugger
    @user= user.update(name: params[:user][:name])
    #debugger
      redirect_to profile_path(params[:id])

  end

  private

  def user_exists?
    unless User.exists?(id: params[:id])
      render plain: "user not exist"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:name, :email)
  end


end