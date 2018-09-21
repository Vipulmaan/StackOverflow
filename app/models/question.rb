class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :favorite_users, class_name: "UserFavoriteQuestion", dependent: :destroy
  validates :body, :length => { :in => 5..1000 }
  validates :title, :length => { :in => 5..1000 }
end
