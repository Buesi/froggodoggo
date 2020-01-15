class AddProfilePublicToFounders < ActiveRecord::Migration[6.0]
  def change
    add_column :founders, :profile_public, :boolean
  end
end
