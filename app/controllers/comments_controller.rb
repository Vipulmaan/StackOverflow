class CommentsController < ApplicationController


  before_action :authenticate_user
  before_action :find_parent
  before_action :find_comment, only: [:show, :edit, :update, :destroy]
  before_action :update_comment, only: [:edit, :update, :destroy]


  def edit
    @question=find_question
    unless params[:answer_id]
      render :partial => "comments/edit_comment_question"
    else
      render :partial => "comments/edit_comment_for_answer"
    end
  end

  def new

  end

  def index
    find_route
  end

  def show
    find_route
  end


  def create
    @comment = @parent.comments.new(comment_params)
    @comment.save!
    find_route

  end

  def update
    @comment.update_attributes!(comment_params)
   find_route

  end

  def destroy
    @comment.destroy
    find_route

  end


  private

  def comment_params
    params.require(:comment).permit(:description).merge(user_id: current_user.id)
  end



  def find_parent
    @question= find_question
    if  params[:answer_id]
     @parent=Answer.find_by!(id:params[:answer_id])
    else
     @parent=@question
    end
  end


  def find_comment
    @comment=Comment.find_by!(id: params[:id])
  end


  def find_question
    @question=Question.find_by!(user_id: params[:user_id] , id: params[:question_id])
  end

  def find_route
    redirect_to user_question_path(params[:user_id], params[:question_id])
  end


  def update_comment
    if @comment.user_id != current_user.id
      raise Error::CustomError.new(message: "You can not do any change in this comment")
    end
  end

end

