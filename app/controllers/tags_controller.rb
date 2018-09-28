class TagsController < ApplicationController

  before_action :authenticate_user
  before_action :parent_exists
  before_action :tag_exists, only: [:edit, :update, :destory]
  def index
    @tags = parent.tags
  end


  def new
    @tag = Tag.new
  end

  def create

    tag_service_call.create_tag(params[:tag][:name])
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
    tag_service_call.update_tag(params[:id], params[:tag][:name])
    find_route
  end

  def destroy

    tag_service_call.delete_tag(params[:id])
    find_route

  end

  private


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

  def tag_service_call
    unless params[:question_id]
      TagService.new({taggable_type: "User", taggable_id: params[:user_id]})
    else
      TagService.new({taggable_type: "Question", taggable_id: params[:question_id]})
    end
  end

  def parent_exists
    if params[:question_id]
      unless Question.exists?(id: params[:question_id], user_id: params[:user_id])
        render plain: "Question not exist"
      end
    else
      unless User.exists?(id: params[:user_id])
        render plain: "User not exists"
      end
    end
  end


  def tag_exists
    unless Tag.exists?(id: params[:id])
      render plain: "tag not exist"
    end
  end
end
