class TagsController < ApplicationController

  def index
    @user=User.find_by(id: params[:user_id])
    @tags=@user.tags
  end

  def new
    @tag=Tag.new
  end

  def create
    @parent = parent
    @tag = @parent.tags.new(tag_params)
    @tag.save
    find_route

  end

  def edit
    @tag = Tag.find_by(id: params[:id])
    @user = User.find(params[:user_id])


  end

  def update
    @parent = parent
    @tag = @parent.tags.find(params[:id])
    @tag.update(tag_params)
    find_route
  end

  def destroy
    Tag.find(params[:id]).destroy
    redirect_to user_tags_path(params[:user_id])
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

  def parent
    if params[:user_id]
      User.find params[:user_id]
    else
      Question.find params[:question_id]
    end
  end

  def find_route
    unless params[:question_id]
       redirect_to user_tags_path(params[:user_id])
    else

  end
end
end
