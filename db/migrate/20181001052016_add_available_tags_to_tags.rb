class AddAvailableTagsToTags < ActiveRecord::Migration[5.2]
  def change
    add_reference :tags, :available_tags, foreign_key: true
  end
end
