class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates :user_id, uniqueness: {scope: :votable_id}
  validates :vote, inclusion: {in: [1, -1,0]}




end





