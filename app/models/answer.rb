class Answer < ApplicationRecord
  include Votable

  belongs_to :user
  belongs_to :question
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  validates :description, presence: true


  def self.correct_answer(question_id, answer_id)
    @question = Question.find(question_id)
    @answers = @question.answers
    @answers.each do |answer|
      if answer.id == answer_id
        answer.update_attributes(:correct => true)
      else
        answer.update_attributes(:correct => false)
      end
    end
  end

end
