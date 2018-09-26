class CreateSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :sessions do |t|
      t.references :user, foreign_key: true
      t.string :Token
      t.datetime :Login_time
      t.datetime :Logout_time
      t.boolean :State

      t.timestamps
    end
  end
end
