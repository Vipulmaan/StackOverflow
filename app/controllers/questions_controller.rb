class QuestionsController < ApplicationController

  #before_action :valid_user_for_update? , :only => :edit

  def new
    @question = Question.new(user_id: params[:user_id])
  end

  def index
    @questions = Question.where(user_id: params[:user_id])
    @question = Question.new(user_id: params[:user_id])
  end

  def show
    @question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: params[:question_id])
  end

  def create

    @question = Question.new(question_params)
    @question.user_id = params[:user_id]
    if @question.save
      redirect_to user_question_path(@question.user_id, @question.id)
    else
      render 'new'
    end
  end

  def edit
    @question = Question.find_by(id: params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update_attributes(question_params)
      redirect_to user_question_path(@question.user_id, @question.id)
    else
      render 'edit'
    end

  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to user_questions_path(params[:user_id])
  end

  private

  def current_user
    User.find_by(id: params[:user_id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def valid_user_for_update?
    @question = Question.find(params[:id])
    if @question.user_id == params[:user_id]
      return true
    else
      return false
    end
  end

end

