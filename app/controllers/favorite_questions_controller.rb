class FavoriteQuestionsController < ApplicationController

  before_action :authenticate_user
  before_action :find_question
  before_action :find_favorite_question , except: [:new , :create ,:index]
  before_action :favorite_questions , only:[:index]

  rescue_from ActiveRecord::RecordInvalid  , :with => :show_already_favorite_message
  rescue_from ActiveRecord::RecordNotFound  , :with => :show_already_unfavorite_message


  def new
    @favorite = UserFavoriteQuestion.new
  end


  def index
    render template: 'questions#index'
  end


  def create

    @favorite_question = UserFavoriteQuestion.new(user_id: current_user.id, question_id: params[:question_id], favorite: true)
    @favorite_question.save!
        redirect_to user_question_path(@question.user_id, params[:question_id]), notice: 'successfully favorite'


  end

  def destroy
      @favorite_question.destroy
      redirect_to user_question_path(@question.user_id, params[:question_id]), notice: 'successfully unfavorite'
  end


  def find_user
  @user=User.find_by!(id: params[:user_id])
  end


  def find_question
   @question= Question.find_by!(id: params[:question_id] , user_id: params[:user_id])
  end

  def favorite_questions
    find_user
    @favorite_questions_id = @user.favorite_questions.pluck(:question_id)
    @questions = Question.where(:id => @favorite_questions_id)
  end

  def find_favorite_question
    @favorite_question=UserFavoriteQuestion.find_by!(user_id: current_user.id , question_id: params[:question_id])
  end


  def show_already_favorite_message
    redirect_to user_question_path(@question.user_id, params[:question_id]), notice: 'already favorite'
  end

  def show_already_unfavorite_message
    redirect_to user_question_path(@question.user_id, params[:question_id]), notice: 'already unfavorite'
  end

end
