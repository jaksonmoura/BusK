class AddScheduleToReturn < ActiveRecord::Migration
  def change
    add_column :returns, :schedule, :string
  end
end
