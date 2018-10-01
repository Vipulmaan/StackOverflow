class UserReputation

  def total_votes(user)
    upvote = 0
    downvote = 0
    user.questions.each do |v|
      upvote += v.votes.where(vote: 1).count
      downvote += v.votes.where(vote: -1).count
      v.answers.each do |answer|
        upvote += answer.votes.where(vote: 1).count
        downvote += answer.votes.where(vote: -1).count
      end
    end
    return upvote - downvote
  end

end