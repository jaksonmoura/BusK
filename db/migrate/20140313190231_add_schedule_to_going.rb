class AddScheduleToGoing < ActiveRecord::Migration
  def change
    add_column :goings, :schedule, :string
  end
end
