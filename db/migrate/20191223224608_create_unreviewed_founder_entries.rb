class CreateUnreviewedFounderEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :unreviewed_founder_entries do |t|
      t.text :role
      t.integer :review_status, default: 0
      t.references :founder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
