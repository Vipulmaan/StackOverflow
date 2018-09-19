class User < ApplicationRecord

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :tags, as: :taggable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorite_questions, class_name: "UserFavoriteQuestion", dependent: :destroy

end
