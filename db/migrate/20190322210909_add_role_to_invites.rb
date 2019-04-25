class AddRoleToInvites < ActiveRecord::Migration[5.2]
  def change
    add_column :invites, :role, :string
  end
end
