class AddDaysOfWeekToGoing < ActiveRecord::Migration
  def change
    add_column :goings, :days_of_week, :string
  end
end
