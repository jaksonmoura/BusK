class AddFrequencyToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :frequency, :integer
  end
end
