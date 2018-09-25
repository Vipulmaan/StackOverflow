class FavoriteQuestionsController < ApplicationController

  before_action :authenticate_user
  before_action :question_exists

  def new
    @favorite = UserFavoriteQuestion.new
  end

  def show

  end

  def create

    @favorite_question = UserFavoriteQuestion.new(user_id: current_user.id, question_id: params[:question_id], favorite: true)
    @question_user = Question.find(params[:question_id])
    unless user_exist?
      if @favorite_question.save
        redirect_to user_question_path(@question_user.user_id, params[:question_id]), notice: 'success'
      end
    end

  end

  def destroy
    if user_exist?
      @favorite_question = UserFavoriteQuestion.find_by(user_id: current_user.id, question_id: params[:question_id])
      @favorite_question.destroy
    end
  end


  def user_exist?
    if UserFavoriteQuestion.exists?(user_id: current_user.id, question_id: params[:question_id])
      return true
    else
      return false
    end
  end

  def question_exists
    unless Question.exists?(id: params[:question_id])
      render plain: "Question not exist"
    end
  end
end
