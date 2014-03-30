class AddDaysOfWeekToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :days_of_week, :string
  end
end
