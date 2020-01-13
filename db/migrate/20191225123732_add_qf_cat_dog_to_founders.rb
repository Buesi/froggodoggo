class AddQfCatDogToFounders < ActiveRecord::Migration[6.0]
  def change
    add_column :founders, :profile_pic, :string    
    add_column :founders, :days_per_week, :integer
    add_column :founders, :duration, :integer
    add_column :founders, :specialisation, :integer
    add_column :founders, :company_description, :string
    add_column :founders, :done_so_far, :string
    add_column :founders, :cool_work, :string
    add_column :founders, :impressive_build, :string
    add_column :founders, :important_in_5years, :string
    add_column :founders, :years_in_software, :integer
    add_column :founders, :qf_cat_dog, :string
    add_column :founders, :qf_thrones_breaking, :string
    add_column :founders, :qf_jungle, :string
    add_column :founders, :qf_belt_susp, :string

    remove_column :founders, :role, :string
    remove_column :users, :password, :string
  end
end
