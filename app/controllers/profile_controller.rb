class ProfileController < ApplicationController

  before_action :authenticate_user
  #before_action :user_exists

  def index
    @user = User.find_by(id: params[:user_id])
    @vote = total_votes(@user.id)
    @user.update_attribute(:reputation, @vote)
  end

  def total_votes(id)
    u = User.find(id)
    upvote = 0
    downvote = 0
    u.questions.each do |v|
      upvote += v.votes.where(vote: 1).count
      downvote += v.votes.where(vote: -1).count
      v.answers.each do |answer|
        upvote += answer.votes.where(vote: 1).count
        downvote += answer.votes.where(vote: -1).count
      end
    end
    return upvote - downvote

  end


  def user_exists
    unless User.exists?(id: params[:user_id])
      render plain: "user not exists123"
    end
  end

end
