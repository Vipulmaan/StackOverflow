class AnswersController < ApplicationController

  # before_action :question_exists
  before_action :answer_exists, only: [:show, :edit, :update, :destroy]
  before_action :authorized_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user

  # before_action :answer_exists , only:[]

  def create
    @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user_id = current_user.id
    @answer.save
    redirect_to user_question_path(@question.user_id, @question.id)
  end


  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def show

    @answer = Answer.find(params[:id])
    if params[:validity]
      Answer.correct_answer(params[:question_id], params[:id])
      flash.now[:notice] = "success"
    end

  end

  def edit
    @answer = Answer.find_by(id: params[:id])
    @question = Question.find_by(id: params[:question_id])
    @user = User.find(params[:user_id])
    render :partial => "answers/edit_answers"
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update_attributes(answer_params)
      redirect_to user_question_path(params[:user_id], @answer.question_id)
    else
      render :partial => "answers/edit_answers"
    end

  end

  def destroy
    Answer.find(params[:id]).destroy
    redirect_to user_question_path(params[:user_id], params[:question_id])
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end

  def authorized_user
    @answer = Answer.find(params[:id])
    @user = User.find(@answer.user_id)
    @question = Question.find(params[:question_id])
    unless isadmin?(@user)
      flash.now[:danger] = "You do not have authorization to edit this post"
      redirect_to user_question_path(params[:user_id], @question.id)
    end
  end

  def answer_exists
    unless Answer.exists?(id: params[:id])
      render plain: "answer not exist "
    end
  end

  # def question_exists
  #   unless Question.exists?(id: params[:question_id] , user_id: params[:user_id])
  #     render plain: "question not exist "
  #   end
  # end


end
