class RemoveQfBeltSuspFromUnreviewedFounderEntries < ActiveRecord::Migration[6.0]
  def change

    remove_column :unreviewed_founder_entries, :qf_belt_susp, :string
  end
end
