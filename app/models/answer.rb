class Answer < ApplicationRecord
  include Votable
  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates :description, presence: true

end
