class VotesController < ApplicationController


  def create

    @parent = parent

    if (params[:upvote])
      Vote.upvote(current_user, @parent.id, params[:type])
    elsif (params[:downvote])
      Vote.downvote(current_user, @parent.id, params[:type])
    end

  end


  private


  def parent
    unless params[:answer_id]
      Question.find params[:question_id]
    else
      Answer.find params[:answer_id]
    end
  end

end

