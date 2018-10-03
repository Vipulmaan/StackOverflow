class TagsController < ApplicationController

  before_action :authenticate_user
  before_action :parent ,except: [:show]
  before_action :find_tag, only: [:destory]


  def index
    @tags=AvailableTag.where(id: parent.tags.pluck(:available_tags_id))
  end

  def new
    @tag = AvailableTag.new
  end

  def show
  
    tag= AvailableTag.find_by!(name: params[:name])
    questions_id=Tag.where(taggable_type: "Question" , available_tags_id: tag.id).pluck(:taggable_id)
    @questions=Question.where(id: questions_id)
  end


  def create
    tag_service_call.create_tag(params[:available_tag][:name])
    find_route
  end


  def destroy

    tag_service_call.delete_tag(params[:available_tag][:name])
    find_route

  end

  private


  def parent

    if params[:question_id]
      Question.find_by!(id: params[:question_id])
    else
      User.find_by!(id:params[:user_id])
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

  def find_tag
    @tag = AvailableTag.find_by!(name: params[:available_tag][:name])
  end

end
