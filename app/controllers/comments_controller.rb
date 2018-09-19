class CommentsController < ApplicationController

  def create

    @user = User.find(params[:user_id])

    if !params[:question_id].nil?
      @question = Question.find(params[:question_id])
      @comment = @question.comments.new(comment_params)
    else
      @answer = Answer.find(params[:answer_id])
      @comment = @answer.comments.new(comment_params)
      @question = @answer.question_id
    end

    @comment.user_id = @user.id
    @comment.save
    if !params[:question_id].nil?
      redirect_to user_question_path(@user.id, @question.id)
    else
      redirect_to user_question_path(@user.id, @answer.question_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end

end
