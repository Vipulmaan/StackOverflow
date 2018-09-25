class QuestionsController < ApplicationController

  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :question_exists, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user


  def new
    @question = Question.new(user_id: current_user.id)
  end

  def index

    if params[:favorite_question]
      user = User.find(params[:user_id])
      favorite_questions = user.favorite_questions
      @favorite_questions_id = favorite_questions.pluck(:question_id)
      @questions = Question.where(:id => @favorite_questions_id)
    elsif params[:user_id]
    @questions = Question.where(user_id: params[:user_id])
    @question = Question.new(user_id: params[:user_id])
    elsif params[:data]
      @questions = call_search_sevice
    else
      @questions = Question.all.sort_by do |question|
        question.votes.sum(:vote)
      end.reverse
    end
  end

  def show

    @user = User.find(params[:user_id])
    @question = Question.find_by(id: params[:id])
    @answers = @question.answers
    @answer = Answer.new(:user_id => current_user.id, :question_id => @question.id)
    @comments = @question.comments
    @comment = @question.comments.new("user_id" => current_user.id)
    @tags = @question.tags
    @tag = Tag.new
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


  def call_search_sevice
    search_service = SearchService.new({class: Question, column: params[:column], data: params[:data]})
    search_service.search
  end

  def question_exists
    unless Question.exists?(params[:id])
      render plain: "question not exist"
    end
  end


end

