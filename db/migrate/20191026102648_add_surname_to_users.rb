class AddSurnameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :surname, :text
  end
end
