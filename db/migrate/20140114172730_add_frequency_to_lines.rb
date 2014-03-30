class AddFrequencyToLines < ActiveRecord::Migration
  def change
    add_column :lines, :frequency, :integer
  end
end
