class FavoriteQuestionsController < ApplicationController

  def new
    @favorite = UserFavoriteQuestion.new
  end

  def show

  end

  def create

    @favorite_question = UserFavoriteQuestion.new(user_id: current_user.id, question_id: params[:question_id], favorite: true)
    @question_user = Question.find(params[:question_id])

    if @favorite_question.save
      redirect_to user_question_path(@question_user.user_id, params[:question_id]), notice: 'success'
    end

  end
end
