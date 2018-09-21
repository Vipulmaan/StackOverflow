class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :user, foreign_key: true
      t.boolean :upvote
      t.boolean :downvote
      t.references :votable, polymorphic: true

      t.timestamps
    end
  end
end
