class AddBasedInToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :based_in, :string
  end
end
