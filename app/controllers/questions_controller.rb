class QuestionsController < ApplicationController
  

  before_action :authenticate_user
  before_action :find_user , except: [:index,:new,:create]
  before_action :find_question, only: [:valid_answer, :show, :edit, :update, :destroy]
  before_action :update_question , only: [ :valid_answer, :edit, :update, :destroy]
  

  def new
    @question = Question.new(user_id: current_user.id)
  end


  def index

    if params[:favorite_question]
       favorite_questions
    elsif params[:user_id]
       user_specific_questions
     @question = Question.new
    elsif params[:data]
      call_search_sevice
    else
      @questions = QuestionService.new.all_questions_sort_by_vote
    end

  end

  def show
    @answers = @question.answers
    @answer = Answer.new(:user_id => current_user.id, :question_id => @question.id)
    @comments = @question.comments
    @comment = @question.comments.new("user_id" => current_user.id)
    @available_tags_id = @question.tags
    @tags=AvailableTag.where(id: @available_tags_id)
    @tag = AvailableTag.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      redirect_to user_question_path(@question.user_id, @question.id)
    else
      render 'new'
    end

  end


  def edit

  end

  def update
    if @question.update_attributes!(question_params)
      redirect_to user_question_path(@question.user_id, @question.id)
    else
      render 'edit'
    end
  end


  def destroy
    @question.destroy
    redirect_to user_questions_path(params[:user_id])
  end



  def valid_answer
    @question.update_attributes!(valid_answer_id: params[:answer_id].to_i)
    redirect_to user_question_path(@question.user_id, @question.id) , notice: "successfully update"
  end



  private


  def question_params
    params.require(:question).permit(:title, :body).merge(user_id:current_user.id)
  end


  def call_search_sevice

    search_service = SearchService.new({class: Question, column: "title", data: params[:data]})
    @questions= search_service.search

  end

  def find_question
     @question=Question.find_by!(id: params[:id] , user_id: params[:user_id])
  end

  def find_user
    @user=User.find_by!(id: params[:user_id])
  end

  def update_question
    if params[:user_id] != current_user.id.to_s
      raise Error::CustomError.new(message: "You can not do any change in this question")
    end
  end

  def favorite_questions
    find_user
    @favorite_questions_id = @user.favorite_questions.pluck(:question_id)
    @questions = Question.where(:id => @favorite_questions_id)
  end


  def user_specific_questions
    find_user
    @questions = Question.where(user_id: params[:user_id])
  end

  

end

