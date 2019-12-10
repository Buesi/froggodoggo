class AddPaidToContacts < ActiveRecord::Migration[6.0]
  def change
    add_column :contacts, :paid, :boolean
  end
end
