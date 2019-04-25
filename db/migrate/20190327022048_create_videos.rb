class CreateVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :videos do |t|
      t.string :video_url
      t.string :slides_url
      t.string :speaker_url
      t.date :recorded_at
      t.string :title
      t.string :speaker
      t.text :summary
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end
