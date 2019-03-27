class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :link
      t.string :title
      t.string :speaker
      t.integer :user_id

      t.timestamps
    end
  end
end
