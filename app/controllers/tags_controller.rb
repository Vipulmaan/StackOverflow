class TagsController < ApplicationController

  def index
    @tags = parent.tags
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
    if params[:question_id]
      @question = Question.find(params[:question_id])
      render :partial => "tags/update_tag"
    else
      @user = User.find(params[:user_id])
    end
  end

  def update
    @parent = parent
    @tag = @parent.tags.find(params[:id])
    @tag.update(tag_params)
    find_route
  end

  def destroy
    Tag.find(params[:id]).destroy
    find_route
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end

  def parent
    if params[:question_id]
      Question.find params[:question_id]
    else
      User.find params[:user_id]
    end
  end

  def find_route
    unless params[:question_id]
       redirect_to user_tags_path(params[:user_id])
    else
      redirect_to user_question_path(current_user.id, params[:question_id])
    end
end
end
