class CommentsController < ApplicationController

  before_action :valid_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user
  def edit
    @comment = Comment.find_by(id: params[:id])
    @user = User.find(params[:user_id])
    unless params[:answer_id]
      render :partial => "comments/edit_comment_question"
    else
      @answer = Answer.find(params[:answer_id])
      render :partial => "comments/edit_comment_for_answer"
    end
  end

  def create
    @parent = parent
    @comment = @parent.comments.new(comment_params)
    @comment.save
    find_route
  end

  def update
    @parent = parent
    @comment = @parent.comments.find(params[:id])
    @comment.update(comment_params)
    find_route

  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to user_question_path(params[:user_id], params[:question_id])
  end


  private

  def comment_params
    params.require(:comment).permit(:description).merge(user_id: current_user.id)
  end

  def parent
    unless params[:answer_id]
      Question.find params[:question_id]
    else
      Answer.find params[:answer_id]
    end
  end

  def valid_user
    @comment = Comment.find(params[:id])
    @user = User.find(@comment.user_id)
    unless isadmin?(@user)
      flash.now[:danger] = "You do not have authorization to edit this post"
      find_route
    end
  end

  def commentable_key
    if params[:question_id]
      retrun params[:question_id]
    else
      return params[:answer_id]
    end


  end

  def find_route
    unless params[:question_id]
      @answer = Answer.find(params[:answer_id])
      redirect_to user_question_path(params[:user_id], @answer.question_id)
    else
      redirect_to user_question_path(params[:user_id], params[:question_id])
    end
  end

end

