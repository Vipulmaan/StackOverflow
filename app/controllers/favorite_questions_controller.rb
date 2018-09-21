class FavoriteQuestionsController < ApplicationController

  def new
    @favorite = UserFavoriteQuestion.new
  end

  def show

  end

  def create

   # @favorite = UserFavoriteQuestion.new(params[:id])
    @favorite_question=UserFavoriteQuestion.new(user_id:current_user.id,question_id:params[:question_id],favorite:true)
    if @favorite_question.save
      redirect_to 'users/', notice: 'Invalid entry....'
    end


  end
end
