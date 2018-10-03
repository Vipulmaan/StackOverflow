class AddValidAnswerToQuestion < ActiveRecord::Migration[5.2]
  def change
    add_reference :questions, :valid_answer, foreign_key: {to_table: :answers, on_delete: :nullify}
  end
end
