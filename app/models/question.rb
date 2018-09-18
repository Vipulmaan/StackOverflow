class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  has_many :comments, as: :commentable
  has_many :tags, as: :taggable

end
