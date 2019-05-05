class AddContentLinkToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :content_url, :string
  end
end
