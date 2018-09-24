class AddIndexToUserFavoriteQuestions < ActiveRecord::Migration[5.2]
  def change
    add_index :user_favorite_questions, [:user_id, :question_id], unique: true
  end
end
