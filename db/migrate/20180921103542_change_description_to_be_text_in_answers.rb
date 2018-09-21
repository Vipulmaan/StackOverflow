class ChangeDescriptionToBeTextInAnswers < ActiveRecord::Migration[5.2]
  def change
    change_column :answers, :description, :text
  end
end
