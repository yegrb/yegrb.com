class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.datetime :time
      t.string :location
      t.string :signup_link
      t.text :meetup_description
      t.text :content
      t.text :additional_information
      t.text :thank_you

      t.timestamps
    end
  end
end
