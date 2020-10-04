class AddUniqueIndexToEmails < ActiveRecord::Migration[6.0]
  def change
    add_index :invites, :email, unique: true
    add_index :opportunities, :email, unique: true
  end
end
