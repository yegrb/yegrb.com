# typed: true
class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :user_id
      t.string :title
      t.datetime :time
      t.string :location
      t.string :url
      t.text :content

      t.timestamps
    end
  end
end
