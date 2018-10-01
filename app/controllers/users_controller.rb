  class UsersController < ApplicationController


     before_action :find_user, :only => [:show,:edit,:destroy,:update]
     before_action :authenticate_user, :only => [:show,:edit,:destroy,:update]



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
       @vote=  User.total_votes(@user)
    end

    def create

      @user = User.new(user_params)
      if @user.password == @user.password_confirmation
        if @user.save
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
     @user.destroy
      flash[:success] = 'User successfully deleted!'
      redirect_to '/logout'
    end

    def edit

    end


  def update
    user=User.find(params[:id])
    #debugger
    @user= user.update(name: params[:user][:name], email: params[:user][:email])
    #debugger
      redirect_to user_path(params[:id])
  end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


    def find_user
      @user=User.find_by!(id: params[:id])
    end


  end

