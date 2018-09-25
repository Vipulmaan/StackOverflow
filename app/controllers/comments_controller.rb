class CommentsController < ApplicationController


  before_action :authenticate_user
  before_action :parent_exists, only: [:show, :edit, :update, :destroy]
  before_action :comment_exists, only: [:show, :edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]


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


  def index
    redirect_to user_question_path(params[:user_id], params[:question_id])
  end

  def show
    redirect_to user_question_path(params[:user_id], params[:question_id])
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

  def authorized_user
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

  def parent_exists
    unless params[:answer_id]
      unless Comment.exists?(user_id: params[:user_id], commentable_id: params[:question_id])
        render plain: "Question not exist"
      end
    else
      if Question.exists?(id: params[:question_id], user_id: params[:user_id])
        unless Comment.exists?(commentable_id: params[:answer_id])
          render plain: "comments not exist"
        end
      else
        render plain: "question not exist"
      end
    end

  end


  def comment_exists
    unless Comment.exists?(id: params[:id])
      render plain: "comment not exist"
    end
  end

  def answer_exists?
    unless Answer.exists?(id: params[:answer_id], question_id: params[:question_id], user_id: params[:user_id])
      return false
      render plain: "Answer not exists"
    else
      return true
    end
  end

end

