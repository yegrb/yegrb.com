class AddAltLocationToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :alt_location_url, :string
  end
end
