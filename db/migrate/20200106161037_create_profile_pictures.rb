class CreateProfilePictures < ActiveRecord::Migration[6.0]
  def change
    create_table :profile_pictures do |t|
      t.integer :color
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
