class AddBasedInToFounders < ActiveRecord::Migration[6.0]
  def change
    add_column :founders, :based_in, :string
  end
end
