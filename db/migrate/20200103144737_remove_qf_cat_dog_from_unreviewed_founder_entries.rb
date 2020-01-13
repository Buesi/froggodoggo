class RemoveQfCatDogFromUnreviewedFounderEntries < ActiveRecord::Migration[6.0]
  def change

    remove_column :founders, :profile_pic, :string

    remove_column :unreviewed_founder_entries, :profile_pic, :string    
    remove_column :unreviewed_founder_entries, :days_per_week, :integer
    remove_column :unreviewed_founder_entries, :duration, :integer
    remove_column :unreviewed_founder_entries, :specialisation, :integer
    remove_column :unreviewed_founder_entries, :years_in_software, :integer
    remove_column :unreviewed_founder_entries, :qf_cat_dog, :string
    remove_column :unreviewed_founder_entries, :qf_thrones_breaking, :string
    remove_column :unreviewed_founder_entries, :qf_jungle, :string
    
    add_column :users, :profile_pic, :integer   

  end
end
