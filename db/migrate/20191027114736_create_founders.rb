class CreateFounders < ActiveRecord::Migration[6.0]
  def change
    create_table :founders do |t|
      t.text :company
      t.text :website
      t.text :github
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
