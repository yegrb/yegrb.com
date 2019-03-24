class AddCodeToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :code, :string
  end
end
