class RemoveDaysOfWeekFromLines < ActiveRecord::Migration
  def change
    remove_column :lines, :days_of_week, :string
  end
end
