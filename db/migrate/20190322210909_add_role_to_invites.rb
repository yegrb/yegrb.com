class AddRoleToInvites < ActiveRecord::Migration[6.0]
  def change
    add_column :invites, :role, :string
  end
end
