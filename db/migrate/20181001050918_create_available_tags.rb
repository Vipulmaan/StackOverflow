class CreateAvailableTags < ActiveRecord::Migration[5.2]
  def change
    create_table :available_tags do |t|
      t.string :name

      t.timestamps
    end
    add_index :available_tags, :name , unique: true
  end
end
