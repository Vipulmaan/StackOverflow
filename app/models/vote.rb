class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates :user_id, uniqueness: {scope: :votable_id}
  validates :vote, inclusion: {in: [1, -1, nil]}


  def self.upvote(user, id, type)
    if !user_exist?(user, id)
      cast_vote(user, id, 1, type)
    else
      vote = find_value(user, id)
      puts vote.inspect
      value = vote.vote
      if (value == -1 || !value.present?)
        update_vote(vote, user, id, 1)
      end
    end
  end

  def self.downvote(user, id, type)
    if !user_exist?(user, id)
      cast_vote(user, id, -1, type)

    else
      vote = find_value(user, id)
      value = vote.vote
      if (value == 1 || !value.present?)
        update_vote(vote, user, id, -1)
      end

    end

  end


  private

  def self.user_exist?(user, id)
    if Vote.exists?(user_id: user.id, votable_id: id)
      puts "exist"
      return true
    else
      puts "not exist"
      return false
    end
  end

  def self.cast_vote(user, id, vote, type)
    @vote = Vote.new(user_id: user.id, votable_id: id, vote: vote, votable_type: type)
    @vote.save
    puts @vote.inspect
  end

  def self.update_vote(v, user, id, vote)
    v.update_attributes(user_id: user.id, votable_id: id, vote: vote)
  end

  def self.find_value(user, id)
    Vote.where(user_id: user.id, votable_id: id).first
  end


end





