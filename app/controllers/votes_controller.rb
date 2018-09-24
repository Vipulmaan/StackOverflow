class VotesController < ApplicationController


  def create
    if (params[:upvote])
      upvote
    elsif (params[:downvote])
      downvote
    elsif (params[:remove_upvote])
      remove_upvote
    elsif (params[:remove_downvote])
      remove_downvote
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
    unless params[:answer_id]
      Question.find params[:question_id]
    else
      Answer.find params[:answer_id]
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

  def remove_upvote
    if vote_service_call.already_upvote?
      vote_service_call.remove_upvote
      flash.notice = "remove upvote"
    else
      flash.notice = "you need to first upvote"
    end
  end


  def remove_downvote
    if vote_service_call.already_downvote?
      vote_service_call.remove_downvote
      flash.notice = "remove downvote"
    else
      flash.notice = "you need to first downvote"
    end
  end

end




