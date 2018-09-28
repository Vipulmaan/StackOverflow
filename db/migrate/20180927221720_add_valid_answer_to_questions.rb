class AddValidAnswerToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :valid_answer, :Integer
  end
end
