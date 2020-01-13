class MoveRoleFromUserToFounder < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role
    add_column :founders, :role, :string
  end
end
