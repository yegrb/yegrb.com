class AddRuntimeToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :runtime, :integer
  end
end
