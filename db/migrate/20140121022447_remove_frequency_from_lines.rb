class RemoveFrequencyFromLines < ActiveRecord::Migration
  def change
    remove_column :lines, :frequency, :integer
  end
end
