class VoteService


  def initialize(params)
    @type = params[:type]
    @votable_id = params[:id]
    @user_id = params[:user_id]
  end

  def upvote
    if already_downvote?
      update_vote(find_value, 1)
    else
      cast_vote(1)
    end
  end

  def remove_upvote
    if already_upvote?
      find_value.destroy
    end
  end

  def downvote
    if already_upvote?
      update_vote(find_value, -1)
    else
      cast_vote(-1)
    end

  end

  def remove_downvote
    if already_downvote?
      find_value.destroy
    end
  end

  def already_upvote?
    if user_exist? && find_value.vote == 1
      return true
    else
      return false
    end
  end

  def already_downvote?
    if user_exist? && find_value.vote == -1
      return true
    else
      return false
    end
  end

  def total_upvote(parent)
    parent.votes.where(vote: 1).count
  end

  def total_downvote(parent)
    parent.votes.where(vote: -1).count
  end


  private

  def user_exist?
    if Vote.exists?(user_id: @user_id, votable_id: @votable_id)
      return true
    else
      return false
    end
  end

  def cast_vote(vote)
    @vote = Vote.new(user_id: @user_id, votable_id: @votable_id, vote: vote, votable_type: @type)
    @vote.save
  end

  def update_vote(v, vote)
    v.update_attributes(user_id: @user_id, votable_id: @votable_id, vote: vote)
  end

  def find_value
    v = Vote.where(user_id: @user_id, votable_id: @votable_id).first
  end

end