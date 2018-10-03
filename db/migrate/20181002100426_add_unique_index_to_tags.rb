class AddUniqueIndexToTags < ActiveRecord::Migration[5.2]
  def change
  	add_index :tags, [:taggable_type, :taggable_id, :available_tags_id], unique: true , :name => 'by_unique_tags'
  end
end
