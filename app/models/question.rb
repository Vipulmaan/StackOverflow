
class Question < ApplicationRecord

  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :favorite_users, class_name: "UserFavoriteQuestion", dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates :title, presence: true, :length => { :in => 5..1000 }
  validates :body, presence: true


end
