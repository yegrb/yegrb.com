class AddRuntimeToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :runtime, :integer
  end
end
