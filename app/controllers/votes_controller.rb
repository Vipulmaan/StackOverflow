class VotesController < ApplicationController

  before_action :authenticate_user
  before_action :find_question


  def create
    if (params[:upvote])
      upvote
    elsif (params[:downvote])
      downvote
    end
  end

  def index
    @upvote = total_upvote
    @downvote = total_downvote
  end

  def total_upvote
    @parent = parent
    vote_service_call.total_upvote(@parent)
  end

  def total_downvote
    @parent = parent
    vote_service_call.total_downvote(@parent)
  end

  private

  def parent
    @question=find_question
    unless params[:answer_id]
      @question
    else
      find_answer
    end
  end

  def vote_service_call
    @parent = parent
    VoteService.new({type: params[:type], user_id: current_user.id, id: @parent.id})
  end

  def upvote
    if vote_service_call.already_upvote?
      flash.notice = "already upvote"
    else
      vote_service_call.upvote
      flash.notice = "successfully upvote"
    end
  end

  def downvote
    if vote_service_call.already_downvote?
       flash.notice = "already downvote"
    else
      vote_service_call.downvote
      flash.notice = "successfully downvote"
    end
  end


  def find_question
   Question.find_by!(id: params[:question_id])
  end

  def find_answer
    Answer.find_by!(id: params[:answer_id], question_id: params[:question_id])
  end

end




