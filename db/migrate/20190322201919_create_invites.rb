class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.string :name
      t.string :email
      t.string :code
      t.datetime :expiry
      t.integer :user_id

      t.timestamps
    end
  end
end
