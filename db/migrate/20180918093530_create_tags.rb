class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.references :taggable, polymorphic: true
      t.string :name

      t.timestamps
    end
    add_index :tags, :name
  end
end
