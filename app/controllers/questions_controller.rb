class QuestionsController < ApplicationController

  before_action :authorize_user, only: [:edit, :update, :destroy]


  def new
    @question = Question.new(user_id: params[:user_id])
  end

  def index
    @questions = Question.where(user_id: params[:user_id])
    @question = Question.new(user_id: params[:user_id])
  end

  def show

    @user = User.find(params[:user_id])
    @question = Question.find_by(id: params[:id])
    @answers = Answer.where(question_id: params[:id])
    @answer = Answer.new(:user_id => current_user.id, :question_id => @question.id)
    @comments = @question.comments
    @comment = @question.comments.new("user_id" => params[:user_id])

  end

  def create

    @question = Question.new(question_params)
    @question.user_id = current_user.id
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

  def authorize_user
    @question = Question.find(params[:id])
    @user = User.find(@question.user_id)
    flash.now[:danger] = "You do not have authorization to edit this post"
    unless isadmin?(@user)
      redirect_to user_question_path(@question.user_id, @question.id)
    end

  end

  def question_params
    params.require(:question).permit(:title, :body)
  end


end

