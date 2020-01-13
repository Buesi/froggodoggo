class CreateTechBreakdowns < ActiveRecord::Migration[6.0]
  def change
    create_table :tech_breakdowns do |t|
      t.text :name
      t.integer :proficiency
      t.integer :experience
      t.references :founder, null: false, foreign_key: true

      t.timestamps
    end
  end
end
