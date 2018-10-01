class AnswersController < ApplicationController

  before_action :authenticate_user
  before_action :find_question
  before_action :find_answer, only: [:show, :edit, :update, :destroy]
  before_action :update_answer, only: [:edit, :update, :destroy]


  def create
    @answer = @question.answers.new(answer_params)
    @answer.save!
    redirect_to user_question_path(@question.user_id, @question.id)
  end


  def index
    @answers = @question.answers
  end

  def edit
    render :partial => "answers/edit_answers"
  end

  def update
    if @answer.update_attributes!(answer_params)
      redirect_to user_question_path(params[:user_id], @answer.question_id)
    else
      render :partial => "answers/edit_answers"
    end
  end

  def destroy
    @answer.destroy
    redirect_to user_question_path(params[:user_id], params[:question_id])
  end

  private

  def answer_params
    params.require(:answer).permit(:description).merge(user_id: current_user.id)
  end

  def find_answer
      @answer=Answer.find_by!(id: params[:id] , question_id: params[:question_id])
  end

  def find_question
     @question=Question.find_by!(id: params[:question_id], user_id: params[:user_id])
  end

  def update_answer
    if find_answer.user_id != current_user.id
      raise Error::CustomError.new(message: "You can not do any change in this answer")
    end
  end


end
