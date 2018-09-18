class User < ApplicationRecord
  has_many :questions
  has_many :answers, through: :questions
  has_many :tags, as: :taggable
  has_many :comments, through: :questions, through: :answers
end
