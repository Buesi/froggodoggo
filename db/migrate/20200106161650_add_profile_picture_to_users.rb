class AddProfilePictureToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :profile_picture, foreign_key: true
  end
end
