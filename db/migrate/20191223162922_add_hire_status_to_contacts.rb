class AddHireStatusToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :hire_status, :integer, default: 0
  end
end
