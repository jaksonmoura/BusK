class AddFrequencyToGoing < ActiveRecord::Migration
  def change
    add_column :goings, :frequency, :integer
  end
end
