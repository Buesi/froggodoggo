class RemoveStripeTokenFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :stripe_token, :string
  end
end
