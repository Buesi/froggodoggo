class AddQfCatDogToUnreviewedFounderEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :unreviewed_founder_entries, :profile_pic, :string    
    add_column :unreviewed_founder_entries, :days_per_week, :integer
    add_column :unreviewed_founder_entries, :duration, :integer
    add_column :unreviewed_founder_entries, :specialisation, :integer
    add_column :unreviewed_founder_entries, :company_description, :string
    add_column :unreviewed_founder_entries, :done_so_far, :string
    add_column :unreviewed_founder_entries, :cool_work, :string
    add_column :unreviewed_founder_entries, :impressive_build, :string
    add_column :unreviewed_founder_entries, :important_in_5years, :string
    add_column :unreviewed_founder_entries, :years_in_software, :integer
    add_column :unreviewed_founder_entries, :qf_cat_dog, :string
    add_column :unreviewed_founder_entries, :qf_thrones_breaking, :string
    add_column :unreviewed_founder_entries, :qf_jungle, :string
    add_column :unreviewed_founder_entries, :qf_belt_susp, :string    

    remove_column :unreviewed_founder_entries, :role, :string
  end
end
