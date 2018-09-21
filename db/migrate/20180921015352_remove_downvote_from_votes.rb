class RemoveDownvoteFromVotes < ActiveRecord::Migration[5.2]
  def change
    remove_column :votes, :downvote, :boolean
  end
end
