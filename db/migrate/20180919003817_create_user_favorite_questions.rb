class CreateUserFavoriteQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :user_favorite_questions do |t|
      t.references :user, foreign_key: true
      t.references :question, foreign_key: true
      t.boolean :favorite

      t.timestamps
    end
  end
end
