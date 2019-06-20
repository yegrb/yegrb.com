# typed: true
class CreateOpportunities < ActiveRecord::Migration[5.2]
  def change
    create_table :opportunities do |t|
      t.integer :user_id
      t.string :title
      t.string :company
      t.string :contact
      t.string :email
      t.boolean :paid_position
      t.text :content
      t.datetime :good_until

      t.timestamps
    end
  end
end
