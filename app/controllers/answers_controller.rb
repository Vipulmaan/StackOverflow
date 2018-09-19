class AnswersController < ApplicationController


  def create
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = @user.id
    @answer.save
    redirect_to user_question_path(@user.id, @question.id)
  end

  def destroy

  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end


end
