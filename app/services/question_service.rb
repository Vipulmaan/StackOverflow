class QuestionService


  def all_questions_sort_by_vote
    @questions = Question.all.sort_by do |question|
      question.votes.sum(:vote)
    end.reverse
  end

end