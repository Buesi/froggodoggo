class AddHourlyRateToFounders < ActiveRecord::Migration[6.0]
  def change
    add_column :founders, :hourly_rate, :integer
  end
end
