class AddFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :email, :string
    add_index :users, :email
    add_column :users, :salt, :string
    add_column :users, :reputation, :Integer
    add_column :users, :encrypted_password, :string
  end
end
